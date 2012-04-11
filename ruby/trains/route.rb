class Route
  attr_accessor :origin, :destination, :distance, :stops
  def initialize(origin, destination, distance, stops=1)
    @origin, @destination, @distance, @stops = origin, destination, distance, stops
  end
end
