require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require_relative '../lib/enigma.rb'

class EnigmaTest < Minitest::Test

	def setup
		@enigma = Enigma.new
		@date = "040895"
		@key = "02715"
		@date2 = "123456"
		@key2 = "12345"
		@input = "hello, world"
                @encrypted_message = "keder,sprrdx"
	end

	def test_it_exists
		assert_instance_of Enigma, @enigma
	end

        def test_encrypt
                assert_instance_of Hash, @enigma.encrypt(@input, @key, @date)
                assert_equal @key, @enigma.encrypt(@input, @key, @date)[:key]
                assert_equal @date, @enigma.encrypt(@input, @key, @date)[:date]
                assert_includes @enigma.encrypt(@input, @key, @date)[:encryption], "kede"
        end

        def test_decrypt
                assert_instance_of Hash, @enigma.decrypt(@encrypted_message, @key, @date)
                assert_equal @key, @enigma.decrypt(@encrypted_message, @key, @date)[:key]
                assert_equal @date, @enigma.decrypt(@encrypted_message, @key, @date)[:date]
                assert_includes @enigma.decrypt(@encrypted_message, @key, @date)[:decryption], "hell"
        end

        def test_random_key
                assert_instance_of String, @enigma.random_key
                assert_equal 5, @enigma.random_key.size
        end

end
