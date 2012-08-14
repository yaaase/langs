require './traffic_light'

class DirectionalArrow < TrafficLight
  attr_reader :direction

  def initialize direction
    validate_direction direction
    @direction = direction
    super()
  end

  def validate_direction direction
    raise InvalidDirectionError unless
    [:left, :right].include? direction
  end

end

class InvalidDirectionError < StandardError
  "Directions can only be left or right!"
end
