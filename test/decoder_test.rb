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
                @decoder = Decoder.new(@input, @key, @date)
                @decoder2 = Decoder.new(@input, @key2, @date2)
        end

	def test_it_exists
		assert_instance_of Decoder, @decoder
	end

	def test_its_inheritted_variables
		assert_equal @key, @decoder.key
                assert_equal @key2, @decoder2.key
                assert_equal @input, @decoder.input
        end

	def test_decrypt_iteration_inner
                assert_equal ["h", "e", "l", "l"], \
@decoder.decrypt_iteration_inner(["k", "e", "d", "e"], [-3, -27, -73, -20])
        end

        def test_decrypt_iteration
                assert_equal ["h", "e", "l", "l"], \
@decoder.decrypt_iteration([-3, -27, -73, -20])[0]
                assert_equal 3, @decoder.decrypt_iteration([-3, -27, -73, -20]).size
        end

        def test_decrypt_message
                assert_equal "hello, world", @decoder.decrypt_message
        end

        def test_decrypt_output
                assert_instance_of Hash, @decoder.decrypt_output
                assert_equal @key, @decoder.decrypt_output[:key]
                assert_equal @date, @decoder.decrypt_output[:date]
                assert_equal @decoder.decrypt_message, @decoder.decrypt_output[:decryption]
        end
end
