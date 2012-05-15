require 'test/unit'
require './fib'

class FibTest < Test::Unit::TestCase

  def test_first_fibonacci_number_is_one
    f = Fib.new
    assert_equal(1, f.nth_fib(1))
  end

  def test_second_fib_is_also_one
    f = Fib.new
    assert_equal(1, f.nth_fib(2))
  end

  def test_third_fib_is_two
    f = Fib.new
    assert_equal(2, f.nth_fib(3))
  end

  def test_fourth_fib_is_three
    f = Fib.new
    assert_equal(3, f.nth_fib(4))
  end

  def test_fifth_fib_is_five
    f = Fib.new
    assert_equal(5, f.nth_fib(5))
  end

  def test_sixth_fib_is_eight
    f = Fib.new
    assert_equal(8, f.nth_fib(6))
  end

end
