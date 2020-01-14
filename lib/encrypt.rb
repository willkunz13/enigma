require_relative 'enigma.rb'
require 'pry'

if ARGV[0] == nil
	puts "Need input file, output file"
	exit(1)
end

if ARGV[1] == nil
	puts "Need output file"
	exit(1)
end

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
 
