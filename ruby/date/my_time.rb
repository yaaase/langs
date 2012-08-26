class MyTime
  attr_reader :qty, :unit

  KEY = {
    :d => 24 * 60 * 60,
    :h => 60 * 60,
    :m => 60,
    :s => 1
  }

  UNITS = KEY.keys

  def initialize qty, unit
    raise "Unkown unit - #{unit}" unless UNITS.include? unit
    @qty, @unit = qty, unit
  end

  def == other
    to_b == other.to_b
  end

  def to_b
    qty * KEY[unit]
  end

end
