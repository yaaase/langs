require './my_date_constants'
require './my_date_validations'

class MyDate
  include Comparable
  include MyDateConstants
  include MyDateValidations

  attr_reader :month, :day, :year

  def initialize month, day, year
    validate month, day, year
    @month, @day, @year = month, day, year
  end

  def <=> other
    if @year != other.year
      @year <=> other.year
    elsif @month != other.month
      MONTH[@month] <=> MONTH[other.month]
    else
      @day <=> other.day
    end
  end

  def - other
    raise unless self > other

    if @month == other.month
      @day - other.day
    elsif adjacent_months? other
      partial_month_days other
    else
      total = 0
      months_between(other.month).each do |mo|
        total += DAYS_IN_MONTH[mo]
      end
      total += partial_month_days other
    end
  end

  def == other
    @month == other.month && @day == other.day
  end

  private

  def adjacent_months? other
    MONTH[@month] - MONTH[other.month] == 1
  end

  def partial_month_days other
    @day + (DAYS_IN_MONTH[other.month] - other.day)
  end

  def months_between month
    between = []
    MONTH.each_pair do |mo, num|
      between << mo if MONTH[@month] > num && num > MONTH[month]
    end
    between
  end

end
