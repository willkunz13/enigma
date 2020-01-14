class Coder

	attr_reader :whitelist, :key, :date, :input

	def initialize(input, key, date)
                file = File.open("./file/white_list.txt")
                @whitelist = file.read.chomp.split(//)
		@key = key
		@date = date
		@input = input
        end

	def first
                key[0,2].to_i + date_extractor(-4)
        end

        def second
                key[1,2].to_i + date_extractor(-3)
        end

        def third
                key[2,2].to_i + date_extractor(-2)
        end

        def fourth
                key[3,2].to_i + date_extractor(-1)
        end

        def date_extractor(position)
                local_date = date.to_i**2
                local_date = local_date.to_s[position]
                local_date.to_i
        end

end
