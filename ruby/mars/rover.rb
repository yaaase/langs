class Rover
  attr_reader :x, :y, :heading, :rights, :lefts

  def initialize(x, y, heading)
    @x, @y, @heading = x, y, heading
    @rights = {"N" => "E", "E" => "S", "S" => "W", "W" => "N"}
    @lefts = {"N" => "W", "W" => "S", "S" => "E", "E" => "N"}
  end

end
