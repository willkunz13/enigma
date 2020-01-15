require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require_relative '../lib/enigma.rb'
require_relative '../lib/decoder.rb'
require_relative '../lib/encoder.rb'

class EnigmaTest < Minitest::Test

	def setup
		@enigma = Enigma.new
		@date = "040895"
		@key = "02715"
		@date2 = "123456"
		@key2 = "12345"
		@input = "hello, world"
		@input2 = "goodbye, earth"
                @encrypted_message = "keder,sprrdx"
		@encrypted_message2 = "vtyaqco,ojkohm"
                @encoder1 = Encoder.new(@input, @key, "")
                @encoder1.stubs(:date).returns("654321")
                @decoder1 = Decoder.new(@encrypted_message, @key, "")
                @decoder1.stubs(:date).returns("654321")
	end

	def test_it_exists
		assert_instance_of Enigma, @enigma
	end

        def test_encrypt
                assert_instance_of Hash, @enigma.encrypt(@input, @key, @date)
                assert_equal @key, @enigma.encrypt(@input, @key, @date)[:key]
		assert_equal @key2, @enigma.encrypt(@input2, @key2, @date2)[:key]
                assert_equal @date, @enigma.encrypt(@input, @key, @date)[:date]
                assert_includes @enigma.encrypt(@input, @key, @date)[:encryption], "kede"
		assert_includes @enigma.encrypt(@input2, @key2, @date2)[:encryption], "vtya"
        end

        def test_encrypt_todays_date
                assert_instance_of Hash, @enigma.encrypt(@input, @key)
                assert_equal @key, @enigma.encrypt(@input, @key)[:key]
                @enigma.stubs(:encrypt).returns(@encoder1.encrypt_output)
                assert_equal "654321", @enigma.encrypt[:date]
                refute_includes @enigma.encrypt[:encryption], "kede"
        end

        def test_encrypt_with_random_key
                @enigma.stubs(:random_key).returns("09875")
                assert_instance_of Hash, @enigma.encrypt(@input)
                assert_equal @enigma.random_key, @enigma.encrypt(@input)[:key]
        end

        def test_decrypt
                assert_instance_of Hash, @enigma.decrypt(@encrypted_message, @key, @date)
                assert_equal @key, @enigma.decrypt(@encrypted_message, @key, @date)[:key]
		assert_equal @key2, @enigma.decrypt(@encrypted_message, @key2, @date2)[:key]
                assert_equal @date, @enigma.decrypt(@encrypted_message, @key, @date)[:date]
                assert_includes @enigma.decrypt(@encrypted_message, @key, @date)[:decryption], "hell"
		assert_includes @enigma.decrypt(@encrypted_message2, @key2, @date2)[:decryption], "good"
        end

        def test_decrypt_todays_date
                assert_instance_of Hash, @enigma.decrypt(@encrypted_message, @key)
                assert_equal @key, @enigma.decrypt(@encrypted_message, @key)[:key]
                @enigma.stubs(:decrypt).returns(@decoder1.decrypt_output)
                assert_equal "654321", @enigma.decrypt[:date]
                refute_includes @enigma.decrypt[:decryption], "hell"
        end

        def test_random_key
                assert_instance_of String, @enigma.random_key
                assert_equal 5, @enigma.random_key.size
        end

end
