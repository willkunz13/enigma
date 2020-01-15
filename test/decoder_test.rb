require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require_relative '../lib/decoder.rb'

class DecoderTest < Minitest::Test

	def setup
		@date = "040895"
                @key = "02715"
                @date2 = "123456"
                @key2 = "12345"
                @input = "keder,sprrdx"
		@input2 = "vtyaqco,ojkohm"
                @decoder = Decoder.new(@input, @key, @date)
                @decoder2 = Decoder.new(@input2, @key2, @date2)
        end

	def test_it_exists
		assert_instance_of Decoder, @decoder
		assert_instance_of Decoder, @decoder2
	end

	def test_its_inheritted_variables
		assert_equal @key, @decoder.key
                assert_equal @key2, @decoder2.key
                assert_equal @input, @decoder.input
		assert_equal @input2, @decoder2.input
        end

	def test_decrypt_iteration_inner
                assert_equal ["h", "e", "l", "l"], \
			@decoder.decrypt_iteration_inner(["k", "e", "d", "e"], [-3, -27, -73, -20])
		assert_equal ["g", "o", "o", "d"], \
			@decoder2.decrypt_iteration_inner(["v", "t", "y", "a"], [-15, -32, -37, -51])
        end

        def test_decrypt_iteration
                assert_equal ["h", "e", "l", "l"], \
			@decoder.decrypt_iteration([-3, -27, -73, -20])[0]
                assert_equal 3, @decoder.decrypt_iteration([-3, -27, -73, -20]).size
		assert_equal ["g", "o", "o", "d"], \
			@decoder2.decrypt_iteration([-15, -32, -37, -51])[0]
		assert_equal 4, @decoder2.decrypt_iteration([-15, -32, -37, -51]).size
        end

        def test_decrypt_message
                assert_equal "hello, world", @decoder.decrypt_message
		assert_equal "goodbye, earth", @decoder2.decrypt_message
        end

        def test_decrypt_output
                assert_instance_of Hash, @decoder.decrypt_output
                assert_equal @key, @decoder.decrypt_output[:key]
		assert_equal @key2, @decoder2.decrypt_output[:key]
                assert_equal @date, @decoder.decrypt_output[:date]
		assert_equal @date2, @decoder2.decrypt_output[:date]
                assert_equal @decoder.decrypt_message, @decoder.decrypt_output[:decryption]
		assert_equal @decoder2.decrypt_message, @decoder2.decrypt_output[:decryption]
        end
end
