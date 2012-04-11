require '/home/mbillie/langs/ruby/trains/route'

class Parser

  def parse(route)
    Route.new(route[0], route[1], route[2].to_i)
  end

end
