require 'test/unit'
require './collatz'

class CollatzTest < Test::Unit::TestCase

	def test_can_determine_number_in_collatz_chain
		c = Collatz.new
		assert_equal(10, c.chain_length(13))
		assert_equal(11, c.chain_length(26))
		assert_equal(10, c.hash[13])
		assert_equal(11, c.hash[26])
		assert_equal(12, c.chain_length(52))
		assert_equal(12, c.hash[52])
	end

end