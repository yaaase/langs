Dir[File.dirname(__FILE__)].each { |file| require file }
require 'test/unit'

class TrafficLightTest < Test::Unit::TestCase

  def test_lights_change_in_order
    t = TrafficLight.new
    assert_equal :green, t.color
    t.turn
    assert_equal :yellow, t.color
    t.turn
    assert_equal :red, t.color
    t.turn
    assert_equal :green, t.color
  end

end
