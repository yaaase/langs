class Airplane
  attr_reader :origin, :destination, :airports

  def initialize origin, destination
    @origin, @destination = origin, destination
    @airports = [@origin, @destination]
  end

  def new_route origin, destination
    @origin, @destination = origin, destination
    @airports << @origin if !@airports.include? @origin
    @airports << @destination if !@airports.include? @destination
  end

  def unique_routes
    unique_pairs @airports.size
  end

  def knows_route? origin, destination
    @airports.include?(origin) && @airports.include?(destination)
  end

  def food_sucks?
    true
  end

  def is_delayed?
    true
  end

  def allow_smoking
    raise StupidAssholeError
  end

  def can_fly *args
    args.each { |a|
      return false if !@airports.include? a
    }
    true
  end

  def unique_pairs size
    return 1 if size < 3
    return (size - 1) + unique_pairs(size - 1)
  end

end

class StupidAssholeError < RuntimeError
end