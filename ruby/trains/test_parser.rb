require 'test/unit'
require '/home/mbillie/langs/ruby/trains/parser'
require '/home/mbillie/langs/ruby/trains/train'

class ParserTest < Test::Unit::TestCase

  def test_should_parse_routes
    parser = Parser.new
    route = parser.parse("AB5")
    assert_equal("A", route.origin)
    assert_equal("B", route.destination)
    assert_equal(5, route.distance)
    assert_equal(1, route.stops)
  end

  def test_can_add_routes
    train = Train.new
    train.add_route(Parser.new.parse("AB5"))
    assert_equal(1, train.routes.size)
  end

  def test_knows_if_route_exists
    train = Train.new
    train.add_route(Parser.new.parse("AB5"))
    train.add_route(Parser.new.parse("BC4"))
    assert_equal(true, train.route_exists?("A","B"))
    assert_equal(true, train.route_exists?("A","C"))
  end

  def test_can_handle_complex_routes
    train = Train.new
    train.add_route(Parser.new.parse("AB5"))
    train.add_route(Parser.new.parse("BC4"))
    train.add_route(Parser.new.parse("CD8"))
    train.add_route(Parser.new.parse("DC8"))
    train.add_route(Parser.new.parse("DE6"))
    train.add_route(Parser.new.parse("AD5"))
    train.add_route(Parser.new.parse("CE2"))
    train.add_route(Parser.new.parse("EB3"))
    train.add_route(Parser.new.parse("AE7"))
    assert_equal(true, train.route_exists?("A","D"))
    assert_equal(true, train.route_exists?("C","C"))
    assert_equal(true, train.route_exists?("A","E"))
    assert_equal(false, train.route_exists?("E","A"))
    assert_equal(true, train.route_exists?("C","B"))
    assert_equal(true, train.recurse_exists?("A","D"))
  end

end
