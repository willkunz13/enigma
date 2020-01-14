class Coder

	attr_reader :whitelist, :key, :date, :input

	def initialize(input, key , date)
                file = File.open("./file/white_list.txt")
                @whitelist = file.read.chomp.split(//)
		@key = key
		@date = date
		@input = input
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

end
