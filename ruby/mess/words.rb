class WordGrabber

  def initialize
    @dictionary = []
    File.open("/usr/share/dict/words") do |file|
      while line = file.gets
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
