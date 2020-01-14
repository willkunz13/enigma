require 'date'
require_relative 'encoder.rb'
require_relative 'decoder.rb'

class Enigma

	def initialize
	end

	def encrypt(input, key = random_key, date = DateTime.now.strftime("%d%m%y"))
		encoder = Encoder.new(input, key, date)
		encoder.encrypt_output
	end

	 
	def decrypt(input, key, date = DateTime.now.strftime("%d%m%y"))
		decoder = Decoder.new(input, key, date)
		decoder.decrypt_output
	end

	def random_key
                counter = 0
                limit = 5
                numbers = []
                while counter != limit
                        number = rand(10)
                        numbers << number
                        counter += 1
                end
                numbers.join.to_s
        end	

end
