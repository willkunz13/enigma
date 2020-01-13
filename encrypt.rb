require_relative './lib/enigma.rb'
require 'pry'

message_file_name = ARGV[0]
output_file_name = ARGV[1]


message_file = File.open('./file/' + message_file_name, "r")
message = message_file.read.chomp
message_file.close

enigma = Enigma.new

output = enigma.encrypt(message)
output_file = File.open('./file/' + output_file_name, "w")
output_file.write(output)
output_file.close
puts "Created \'" + output_file_name + "\' with key " + output[:key] + \
" and date " + output[:date]
 
