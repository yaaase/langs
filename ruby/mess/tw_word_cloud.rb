require 'rubygems'
require 'net/http'
require 'json'

class SearchTerms
  attr_reader :terms
  def initialize
    @terms = []
    File.open("/home/mbillie/langs/ruby/mess/search_terms.txt", "r") do |file|
      while (line = file.gets)
        @terms << line.strip
      end
    end
  end
end

class GoogleSearch
  def look_up(search_term)
    @temp = search_term
    @query = "site:thoughtworks.com/blogs+#{@temp.split(" ").join("+")}"
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
    begin
      return data["queries"]["request"][0]["totalResults"]
    rescue NoMethodError => ex
      return 0
    end
  end
end

class MainProgram
  def initialize
    @terms_and_results = {}
    @searcher = SearchTerms.new
    @google = GoogleSearch.new
    @parser = WordParser.new
  end
  def go
    @searcher.terms.each do |term|
      @google.look_up(term)
      @terms_and_results[term.split(" ").join("_")] = @parser.parse(@google.search_results)
      File.open("/home/mbillie/langs/ruby/mess/searches/#{term.split(" ").join("_")}.json", "w") do |file|
        file.puts(JSON.pretty_generate(@google.search_results))
      end
      puts "There were #{@parser.parse(@google.search_results)} results for the search term: #{term}."
      File.open("/home/mbillie/langs/ruby/mess/searches/COUNTER.txt", "a") do |me|
        me.puts("#{@parser.parse(@google.search_results)} : #{term}.")
      end
    end
    File.open("/home/mbillie/langs/ruby/mess/searches/FINAL_SEARCH_RESULTS.txt", "w") do |f|
      f.puts(@terms_and_results)
    end
    puts "Wrote final count to /home/mbillie/langs/ruby/mess/searches/FINAL_SEARCH_RESULTS.txt - exiting program."
  end
end
