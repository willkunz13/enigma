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
	end

	def test_it_exists
		assert_instance_of Coder, @coder
	end

	def test_its_variables
		assert_includes @coder.whitelist, "a"
                assert_includes @coder.whitelist, " "
                refute_includes @coder.whitelist, ","
		assert_equal @key, @coder.key
		assert_equal @date, @coder.date
		assert_equal @input, @coder.input
	end

	def test_first
               assert_equal @coder.first(@key, @date), 3
               assert_equal @coder.first(@key2, @date2), 15           
	end

	def test_first
               assert_equal @coder.first(@key, @date), 3
               assert_equal @coder.first(@key2, @date2), 15           
       end

       def test_second
               assert_equal @coder.second(@key, @date), 27
               assert_equal @coder.second(@key2, @date2), 32          
       end

       def test_third
               assert_equal @coder.third(@key, @date), 73
               assert_equal @coder.third(@key2, @date2), 37           
       end

       def test_fourth
               assert_equal @coder.fourth(@key, @date), 20
               assert_equal @coder.fourth(@key2, @date2), 51          
       end

       def test_date_extractor
               assert_equal 1, @coder.date_extractor(@date, -4)
               assert_equal 0, @coder.date_extractor(@date, -3)
               assert_equal 3, @coder.date_extractor(@date2, -4)
               assert_equal 6, @coder.date_extractor(@date2, -1)      
       end

end
