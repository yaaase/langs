require './directional_arrow'
require 'test/unit'

class DirectionalArrowTest < Test::Unit::TestCase

  def test_directionals_have_a_direction
    d = DirectionalArrow.new :left
    assert_equal :left, d.direction
    d.turn
    assert_equal :yellow, d.color
  end

  def test_directions_can_only_be_left_or_right
    assert_raise InvalidDirectionError do
      d = DirectionalArrow.new :foo
    end
  end

end
