require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'pry'
require_relative '../lib/cracker.rb'

class CrackerTest < Minitest::Test
	

	def setup
		@cracker = Cracker.new("lkmrs,absxmjdkoj", "140120")
	end

	def test_it_exists
		assert_instance_of Cracker, @cracker
	end
end
