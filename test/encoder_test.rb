require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require_relative '../lib/encoder.rb'

class EncoderTest < Minitest::Test

	def setup
                @date = "040895"
                @key = "02715"
                @date2 = "123456"
                @key2 = "12345"
                @input = "hello, world"
		@input2 = "goodbye, earth"
                @encoder = Encoder.new(@input, @key, @date)
		@encoder2 = Encoder.new(@input2, @key2, @date2)
        end

	def test_it_exists
		assert_instance_of Encoder, @encoder
		assert_instance_of Encoder, @encoder2
	end

	def test_its_inheritted_variables
		assert_equal @key, @encoder.key
		assert_equal @key2, @encoder2.key
		assert_equal @input, @encoder.input
		assert_equal @input2, @encoder2.input
	end

	def test_encrypt_iteration_inner
		assert_equal ["k", "e", "d", "e"], \
			@encoder.encrypt_iteration_inner(["h", "e", "l", "l"], [3, 27, 73, 20])
		assert_equal ["v", "t", "y", "a"], \
			@encoder2.encrypt_iteration_inner(["g", "o", "o", "d"], [15, 32, 37, 51])
	end

	def test_encrypt_iteration
		assert_equal ["k", "e", "d", "e"], \
			@encoder.encrypt_iteration([3, 27, 73, 20])[0]
		assert_equal 3, @encoder.encrypt_iteration([3, 27, 73, 20]).size
		assert_equal ["v", "t", "y", "a"], @encoder2.encrypt_iteration([15, 32, 37, 51])[0]
		assert_equal 4, @encoder2.encrypt_iteration([15, 32, 37, 51]).size
	end

	def test_encrypt_message
		assert_equal "keder,sprrdx", @encoder.encrypt_message
		assert_equal "vtyaqco,ojkohm", @encoder2.encrypt_message
	end

	def test_encrypt_output
		assert_instance_of Hash, @encoder.encrypt_output
		assert_equal @key, @encoder.encrypt_output[:key]
		assert_equal @key2, @encoder2.encrypt_output[:key]
                assert_equal @date, @encoder.encrypt_output[:date]
                assert_equal @encoder.encrypt_message, @encoder.encrypt_output[:encryption]
		assert_equal @encoder2.encrypt_message, @encoder2.encrypt_output[:encryption]
	end
		
end	
