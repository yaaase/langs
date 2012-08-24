require './my_date_constants'

module MyDateValidations

  private

  def validate month, day, year
    raise "#{month} is not a valid month" unless month_is_valid? month
    raise "#{day} in #{month}, #{year} is not a valid day" unless day_is_valid? day, month, year
    raise "#{year} is not a valid year" unless year_is_valid? year
  end

  def month_is_valid? month
    MyDateConstants::MONTH.keys.include? month
  end

  def day_is_valid? day, month, year
    return false unless is_integer? day
    return false if day < 1 || day.to_s.size > 2
    if leap_year?(year) && month == :feb
      return false unless day <= 29
    else
      return false unless MyDateConstants::DAYS_IN_MONTH[month] >= day
    end
    true
  end

  def year_is_valid? year
    return false if year.to_s.size > 4
    return false unless is_integer? year
    true
  end

  def is_integer? chars
    chars.to_s.split(//).each do |char|
      return false unless (0..9).to_a.map(&:to_s).include? char
    end
    true
  end

end
