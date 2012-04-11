class City
  attr_accessor :name, :connections

  def initialize(name)
    @name = name
    @connections = {}
  end

  def add_connection(city, distance)
    @connections[city] = distance
  end

  def ==(other)
    return false if other.class != City
    return true if @name == other.name
    return false
  end

end
