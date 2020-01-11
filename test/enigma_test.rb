require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/enigma.rb'

class EnigmaTest < Minitest::Test

	def setup
		@enigma = Enigma.new
		@date = "040895"
		@key = "02715"
		@date2 = "123456"
		@key2 = "12345"
		@message = "hello world"
	end

	def test_its_variables
		assert_includes @enigma.whitelist, "a"
		assert_includes @enigma.whitelist, " "
		refute_includes @enigma.whitelist, ","
	end

	def test_it_exists
		assert_instance_of Enigma, @enigma
	end

	def test_first
		assert_equal @enigma.first(@key, @date), 3
		assert_equal @enigma.first(@key2, @date2), 15		
	end

	def test_second
		assert_equal @enigma.second(@key, @date), 27
		assert_equal @enigma.second(@key2, @date2), 32		
	end

	def test_third
		assert_equal @enigma.third(@key, @date), 73
		assert_equal @enigma.third(@key2, @date2), 37		
	end

	def test_fourth
		assert_equal @enigma.fourth(@key, @date), 20
		assert_equal @enigma.fourth(@key2, @date2), 51		
	end

	def test_date_extractor
		assert_equal 1, @enigma.date_extractor(@date, -4)
		assert_equal 0, @enigma.date_extractor(@date, -3)
		assert_equal 3, @enigma.date_extractor(@date2, -4)
		assert_equal 6, @enigma.date_extractor(@date2, -1)	
	end

	def test_encrypt_iteration
		assert_equal ["k", "e", "d", "e"], @enigma.encrypt_iteration(@message, [3, 27, 73, 20])[0]
		assert_equal 3, @enigma.encrypt_iteration(@message, [3, 27, 73, 20]).size
	end

	def test_encrypt_message
		assert_equal "kede", @enigma.encrypt_message(@message, @key, @date)[0,4]
		assert_equal @message.size, @enigma.encrypt_message(@message, @key, @date).size
	end

	def test_encrypt
		assert_instance_of Hash, @enigma.encrypt(@message, @key, @date)
		assert_equal @key, @enigma.encrypt(@message, @key, @date)[:key]
		assert_equal @date, @enigma.encrypt(@message, @key, @date)[:date]
		assert_equal @enigma.encrypt_message(@message, @key, @date), @enigma.encrypt(@message, @key, @date)[:encryption]
	end
end
