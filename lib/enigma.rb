class Enigma

	attr_reader :whitelist

	def initialize
		file = File.open("../file/white_list.txt")
		@whitelist = file.read.chomp.split(//)
	end

	def encrypt(message, key, date)
		output = {}
		output[:encrtyption] = encrypt_message(message, key, date)
		output[:key] = key
		output[:date] = date
		output
	end
			
	def encrypt_message(message, key, date)
		shifters = []
		shifters << first(key, date)
		shifters << second(key, date)
		shifters << third(key, date)
		shifters << fourth(key, date)
		encrypt_iteration(message.downcase, shifters).flatten.join
	end

	def first(key, date)
		key[0,2].to_i + date_extractor(date, -4)				
	end

	def second(key, date)
		key[1,2].to_i + date_extractor(date, -3)
	end

	def third(key, date)
		key[2,2].to_i + date_extractor(date, -2)
	end

	def fourth(key, date)
		key[3,2].to_i + date_extractor(date, -1)
	end
	
	def date_extractor(date, position)
		date = date.to_i**2
		date = date.to_s[position]
		date.to_i
	end
	
	def encrypt_iteration(message, shifters)
		message = message.split(//).each_slice(4).to_a.map do |letters|
			letters.each_with_index.map do |letter, index|
				if whitelist.include?(letter)
					adjusted_letters = whitelist.rotate(shifters[index])
					adjusted_letters[whitelist.index(letter)]
				else
					letter
				end
			end
		end
					 
	end

	

end
