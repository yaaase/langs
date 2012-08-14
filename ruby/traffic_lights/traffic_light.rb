class TrafficLight
  attr_reader :color

  def initialize
    @color = :green
    @rotations = [:yellow, :red]
  end

  def turn
    @rotations << @color
    @color = @rotations.shift
  end

end
