require_relative './lib/enigma.rb'
require 'pry'

encrypted_file_name = ARGV[0]
output_file_name = ARGV[1]
key = ARGV[2]
date = ARGV[3]

encrypted_file = File.open('./file/' + encrypted_file_name, "r")
encrypted_message = encrypted_file.read.split('"')[1]
encrypted_file.close

enigma = Enigma.new

output = enigma.decrypt(encrypted_message, key, date)
output_file = File.open('./file/' + output_file_name, "w")
output_file.write(output)
output_file.close
binding.pry
puts "Created '" + output_file_name + "' with key " + output[:key] + \
" and date " + output[:date]
 

