require 'rubygems'
require 'net/http'
require 'json'

class RandomWordGrabber
  def initialize
    @dictionary = []
    File.open("/usr/share/dict/words") do |file|
      while (line = file.gets)
        @dictionary << line.strip
      end
    end
  end
  def n_random(n)
    words = []
    while words.size < n do
      holder = @dictionary[rand(@dictionary.size)]
      next if holder =~ /[A-Z]|\'s|s$|ed$/
      words << holder
    end
    words = words.join(" ")
  end
end

class GoogleSearch
  attr_reader :temp
  def initialize(n)
    @temp = RandomWordGrabber.new.n_random(n)
    @query = @temp.split(" ").join("+")
    @api_key = "AIzaSyCM2thaGCxexkLSqcjs6KlUHYxGscIKkl0"
    @cx = "cx=013036536707430787589:_pqjad5hr1a"
    @search_uri = "https://www.googleapis.com/customsearch/v1?key=#{@api_key}&#{@cx}&q=#{@query}&alt=json"
  end
  def search_results 
    url = URI.parse(URI.encode(@search_uri))
    response = Net::HTTP.start(url.host, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      http.get(url.request_uri)
    end
    data = JSON.parse(response.body)
  end
end

class WordParser
  def parse(data)
    random_words = []
    data["items"].each do |hash|
      four_words = /\w+\s\w+\s\w+\s\w+/.match(hash["snippet"])
      four_words.to_s.split(" ").each do |element|
        next if element =~ /\d/
        random_words << element
      end
    end
    random_words.map(&:downcase).join(" ")
  end
end

g = GoogleSearch.new(3)
puts "Search terms were: " + g.temp
puts "Results were: \n" + WordParser.new.parse(g.search_results)
