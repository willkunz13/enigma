require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/enigma.rb'

class EnigmaTest < Minitest::Test

	def setup
		@enigma = Enigma.new
		@date = "040895"
		@key = "02715"
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
	end

	def test_second
		assert_equal @enigma.second(@key, @date), 27
	end

	def test_third
		assert_equal @enigma.third(@key, @date), 73
	end

	def test_fourth
		assert_equal @enigma.fourth(@key, @date), 20
	end


end
