require './my_date_constants'

module MyDateValidations

  private

  def validate month, day, year
    raise unless month_is_valid? month
    raise unless day_is_valid? day, month
    raise unless year_is_valid? year
    true
  end

  def month_is_valid? month
    MyDateConstants::MONTH.keys.include? month
  end

  def day_is_valid? day, month
    return false unless is_integer? day
    return false if day < 1 || day.to_s.size > 2
    return false unless MyDateConstants::DAYS_IN_MONTH[month] >= day
    true
  end

  def year_is_valid? year
    return false if year.to_s.size != 4
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
