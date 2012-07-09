require 'test/unit'
require './factorial'

class TestFactorial < Test::Unit::TestCase

  def test_factorial_method
    assert_equal 120, factorial(5)
  end

  def test_alt_factorial
    assert_equal 120, (1..5).inject(1,&:*)
  end

end
