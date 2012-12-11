require 'open-uri'

class Connection

    def connected?
      begin
        return true if open('http://www.google.com')
      rescue
        return false
      end
    end

end
