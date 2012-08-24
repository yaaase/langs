require './my_date'

class Parser
  class << self
    def date date
      elems = clean(date).split(/\s/)
      mon, day, yr = determine_parts(elems)
      MyDate.new(parse_month(mon),day.to_i,yr.to_i)
    end

    def determine_parts elems
      month = day = year = nil
      elems.each do |e|
        if e.size == 4
          year = e
        elsif e.size == 2 || e.size == 1
          day = e
        else
          month = e
        end
      end

      [month, day, year]
    end

    def clean string
      string.gsub(",","").
        gsub(".","").
        gsub("st","").
        gsub("nd","").
        gsub("th","")
    end

    def parse_month month
      try = month.downcase[0..2].to_sym

      if MyDate::MONTH.keys.include? try
        try
      else
        raise
      end
    end
  end
end
