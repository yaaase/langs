require '/home/mbillie/langs/ruby/trains/parser'
require '/home/mbillie/langs/ruby/trains/route'

class Train
  attr_reader :routes

  def initialize
    @routes = []
    @count = 0
  end

  def add_route(route)
    @routes << route
  end

  def route_exists?(orig, dest)
    @routes.each do |level_one|
      next if level_one.origin != orig
      return true if level_one.destination == dest
      @routes.each do |level_two|
        next if level_two.origin != level_one.destination
        return true if level_two.destination == dest
        @routes.each do |level_three|
          next if level_three.origin != level_two.destination
          return true if level_three.destination == dest
          @routes.each do |level_four|
            next if level_four.origin != level_three.destination
            return true if level_four.destination == dest
            @routes.each do |level_five|
              next if level_five.origin != level_four.destination
              return true if level_five.destination == dest
            end
          end
        end
      end
    end
  return false
  end

  def recurse_exists?(orig, dest)
    @routes.each do |route|
      next if route.origin != orig
      return true if route.destination == dest
      return recurse_exists?(route.destination, dest)
    end
    return false
  end

end
