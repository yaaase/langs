require './my_date'

class Parser
  class << self
    def date date
      elems = clean(date).split(/\s/)
      mo, day, yr = determine_parts(elems)
      MyDate.new(parse_month(mo),day.to_i,yr.to_i)
    end

    private

    def determine_parts elems
      month = day = year = nil
      elems.each do |e|
        if e.to_i.to_s.size == 4
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
      month.downcase[0..2].to_sym
    end
  end
end
