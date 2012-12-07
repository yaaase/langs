require './my_date_constants'
require './my_date_validations'

class MyDate
  include Comparable
  include MyDateConstants
  include MyDateValidations

  attr_reader :month, :day, :year

  def initialize month, day, year
    @days_key =
      leap_year?(year) ?
      DAYS_IN_MONTH_LEAP_YEAR :
      DAYS_IN_MONTH
    validate month, day, year
    @month, @day, @year = month, day, year
  end

  def <=> other
    if year != other.year
      year <=> other.year
    elsif month != other.month
      MONTH[month] <=> MONTH[other.month]
    else
      day <=> other.day
    end
  end

  def - other
    raise SubtractionError unless self > other

    if year == other.year
      days_between_within_same_year other
    elsif adjacent_year? other
      partial_year_days other
    else
      years_between(other) +
        partial_year_days(other)
    end
  end

  def == other
    year == other.year &&
    month == other.month &&
    day == other.day
  end

  def leap_year? yr = @year
    if yr % 400 == 0
      true
    elsif yr % 100 == 0
      false
    elsif yr % 4 == 0
      true
    else
      false
    end
  end

  def to_s
    "#{PRETTY_MONTHS[month]} #{day}, #{year}"
  end

  private

  def before_leap_day?
    leap_year? &&
      self <= MyDate.new(:feb,28,year)
  end

  def after_leap_day?
    leap_year? &&
      self > MyDate.new(:feb,28,year)
  end

  def years_between other
    sum = 0
    (other.year + 1).upto(year - 1) do |yr|
      sum += 1 if leap_year?(yr)
    end
    sum + ((year - other.year - 1) * 365)
  end

  def partial_year_days other
    days_into_year +
      other.send(:days_til_end_of_year)
  end

  def adjacent_year? other
    year - other.year == 1
  end

  def days_into_year
    return day if month == :jan
    finish, sum = (MONTH[month] - 2), 0
    MONTH.keys[0..finish].each do |mon|
      sum += @days_key[mon]
    end
    sum + day
  end

  def days_til_end_of_year
    return days_til_end_of_month if month == :dec
    start, sum = MONTH[month], 0
    MONTH.keys[start..-1].each do |mon|
      sum += @days_key[mon]
    end
    sum + days_til_end_of_month
  end

  def days_til_end_of_month
    @days_key[month] - day
  end

  def days_between_within_same_year other
    if month == other.month
      day - other.day
    elsif adjacent_months? other
      partial_month_days other
    else
      compute_days_for_non_adjacent_months other
    end
  end

  def compute_days_for_non_adjacent_months other
    total = 0
    months_between(other.month).each do |mo|
      total += @days_key[mo]
    end
    total + partial_month_days(other)
  end

  def adjacent_months? other
    MONTH[month] - MONTH[other.month] == 1
  end

  def partial_month_days other
    day + (@days_key[other.month] - other.day)
  end

  def months_between other_month
    [].tap do |between|
      MONTH.each_pair do |mo, num|
        between << mo if MONTH[month] > num &&
          num > MONTH[other_month]
      end
    end
  end
end

class SubtractionError < Exception
  def message
    "Cannot subtract a later date from an earlier one!"
  end
end
