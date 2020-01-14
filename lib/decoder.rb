require_relative 'coder.rb'
class Decoder < Coder

        def initialize(input, key , date)
                super(input, key, date)
        end

	def decrypt_output
                output = {}
                output[:decryption] = decrypt_message
                output[:key] = key
                output[:date] = date
                output
        end

        def decrypt_message
                shifters = []
                shifters << -(first)
                shifters << -(second)
                shifters << -(third)
                shifters << -(fourth)
                decrypt_iteration(shifters).flatten.join
        end

        def decrypt_iteration(shifters)
                local_input = input.downcase.split(//).each_slice(4).to_a.map do |letters|
                        decrypt_iteration_inner(letters, shifters)
                end

        end

        def decrypt_iteration_inner(letters, shifters)
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
