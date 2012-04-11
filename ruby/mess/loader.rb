require 'rubygems'
require 'json'

class JsonParser
  def open(filename)
    myfile = File.read(filename)
    json = JSON.parse(myfile)
    return json
  end
end
