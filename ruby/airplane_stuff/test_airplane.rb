require './airplane'
require 'test/unit'

class AirplaneTest < Test::Unit::TestCase

  def test_airplane_food_sucks
    a = Airplane.new nil, nil
    assert_equal true, a.food_sucks?
  end

  def test_so_many_delays
    a = Airplane.new nil, nil
    assert_equal true, a.is_delayed?
  end

  def test_they_know_where_theyve_come_from
    a = Airplane.new "Atlanta", "Newark"
    assert_equal "Atlanta", a.origin
  end

  def test_and_where_theyre_going
    a = Airplane.new "Atlanta", "Newark"
    assert_equal "Newark", a.destination
  end

  def test_you_cant_even_smoke_for_fucks_sake
    a = Airplane.new nil, nil
    assert_raise StupidAssholeError do
      a.allow_smoking
    end
  end

  def test_they_know_about_airports
    a = Airplane.new "Atlanta", "Newark"
    assert_equal 2, a.airports.size
  end

  def test_they_learn_about_airports
    a = Airplane.new "Atlanta", "Newark"
    a.new_route "Newark", "Boston"
    assert_equal 3, a.airports.size
  end

  def test_unique_pairs
    a = Airplane.new nil, nil
    assert_equal 3, a.unique_pairs(3)
    assert_equal 6, a.unique_pairs(4)
    assert_equal 10, a.unique_pairs(5)
    assert_equal 15, a.unique_pairs(6)
    assert_equal 21, a.unique_pairs(7)
  end

  def test_they_know_about_unique_two_stop_routes
    a = Airplane.new "Atlanta", "Newark"
    a.new_route "Newark", "Boston"
    assert_equal 3, a.unique_routes
    a.new_route "Boston", "Portland"
    assert_equal 6, a.unique_routes
  end

  def test_you_can_ask_if_they_know_a_route
    a = Airplane.new "Atlanta", "Newark"
    a.new_route "Newark", "Boston"
    assert_equal true, a.knows_route?("Atlanta", "Boston")
    assert_equal false, a.knows_route?("Boston", "New York")
  end

  def test_you_can_ask_for_more_complex_routes_too
    a = Airplane.new "Atlanta", "Newark"
    a.new_route "Newark", "Boston"
    a.new_route "Boston", "Portland"
    assert_equal true, a.can_fly("Atlanta", "Boston", "Portland")
    assert_equal false, a.can_fly("Atlanta", "Boston", "New York")
  end

  def test_they_board_in_order
    a = Airplane.new "Atlanta", "Albany"
    a.boarding_zones = [:one,:two,:three]
    assert_equal :one, a.boards_next
    a.boards_next_zone
    assert_equal :two, a.boards_next
    assert_equal [:one], a.boarded_zones
  end

end
