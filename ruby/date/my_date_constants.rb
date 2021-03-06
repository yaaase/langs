module MyDateConstants

  MONTH = {
    :jan => 1,
    :feb => 2,
    :mar => 3,
    :apr => 4,
    :may => 5,
    :jun => 6,
    :jul => 7,
    :aug => 8,
    :sep => 9,
    :oct => 10,
    :nov => 11,
    :dec => 12
  }

  DAYS_IN_MONTH = {
    :jan => 31,
    :feb => 28,
    :mar => 31,
    :apr => 30,
    :may => 31,
    :jun => 30,
    :jul => 31,
    :aug => 31,
    :sep => 30,
    :oct => 31,
    :nov => 30,
    :dec => 31
  }

  DAYS_IN_MONTH_LEAP_YEAR = DAYS_IN_MONTH.merge :feb => 29

  PRETTY_MONTHS = {
    :jan => "January",
    :feb => "February",
    :mar => "March",
    :apr => "April",
    :may => "May",
    :jun => "June",
    :jul => "July",
    :aug => "August",
    :sep => "September",
    :oct => "October",
    :nov => "November",
    :dec => "December"
  }

end
