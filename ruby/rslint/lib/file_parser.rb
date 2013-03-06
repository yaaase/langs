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

  def violations?(meta = false)
    @lines.each do |array|
      line, number = array
      @lint.line_too_long_violation?(line, number)
      @lint.violation?(line, number)
      @lint.exception_violation?(line, number)
      @lint.meta_violation?(line, number) if meta
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
  meta = ARGV.include?("-m")
  FileParser.new(ARGV[1], Lint.new).violations?(meta)
end
