require '/home/mark/langs/ruby/mars/rover'
require 'test/unit'

class RoverTest < Test::Unit::TestCase

  def test_basic_directional_logic
    r = Rover.new(0, 0, "N")
    assert_equal("E", r.rights[r.heading])
  end

end