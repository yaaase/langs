require_relative './lint'

class FileParser
  attr_reader :lines

  def initialize(file_path, lint)
    @lines = []
    @lint = lint

    file = File.open(file_path, 'r')
    file.readlines.each_with_index do |line, number|
      @lines << [line, number + 1]
    end
  end

  def violations?
    @lines.each do |array|
      @lint.line_too_long_violation?(array[0], array[1])
      @lint.violation?(array[0], array[1])
    end

    if @lint.errors.any?
      display_errors
      true
    else
      false
    end
  end

  def display_errors
    puts "You have the following errors:"
    @lint.errors.each do |hash|
      error = hash.keys.first
      line_number = hash.values.first
      puts "Line #{line_number}: #{@lint.send(error)}"
    end
  end
end

if ARGV[0] == 'check' && ARGV[1]
  FileParser.new(ARGV[1], Lint.new).violations?
end
