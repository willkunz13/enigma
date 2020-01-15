require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require_relative '../lib/coder.rb'

class CoderTest < Minitest::Test

	def setup
                @date = "040895"
                @key = "02715"
                @date2 = "123456"
                @key2 = "12345"
                @input = "hello, world"
		@coder = Coder.new(@input, @key, @date)
		@coder2 = Coder.new(@input, @key2, @date2)
	end

	def test_it_exists
		assert_instance_of Coder, @coder
	end

	def test_its_variables
		assert_includes @coder.whitelist, "a"
                assert_includes @coder.whitelist, " "
		assert_includes @coder2.whitelist, " "
                refute_includes @coder.whitelist, ","
		assert_equal @key, @coder.key
		assert_equal @date, @coder.date
		assert_equal @date2, @coder2.date
		assert_equal @input, @coder.input
	end

	def test_first
               assert_equal @coder.first, 3
               assert_equal @coder2.first, 15           
	end


        def test_second
               assert_equal @coder.second, 27
               assert_equal @coder2.second, 32          
        end

        def test_third
               assert_equal @coder.third, 73
               assert_equal @coder2.third, 37           
        end

        def test_fourth
               assert_equal @coder.fourth, 20
               assert_equal @coder2.fourth, 51          
        end

        def test_date_extractor
               assert_equal 1, @coder.date_extractor(-4)
               assert_equal 0, @coder.date_extractor(-3)
               assert_equal 3, @coder2.date_extractor(-4)
               assert_equal 6, @coder2.date_extractor(-1)      
       end

end
