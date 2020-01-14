require_relative 'coder.rb'
class Encoder < Coder

	def initialize(input, key , date)
		super(input, key, date)
	end
 

	def encrypt_output
                output = {}
                output[:encryption] = encrypt_message
                output[:key] = key
                output[:date] = date
                output
        end

	def encrypt_message
                shifters = []
                shifters << first
                shifters << second
                shifters << third
                shifters << fourth
                encrypt_iteration(shifters).flatten.join
        end

	def encrypt_iteration(shifters)
                local_input = input.downcase.split(//).each_slice(4).to_a.map do |letters|
                        encrypt_iteration_inner(letters, shifters)
                end

        end

	def encrypt_iteration_inner(letters, shifters)
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
