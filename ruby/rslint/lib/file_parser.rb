require_relative './lint'

class FileParser
  attr_reader :lines

  UniqueConstant = ";;;;;"

  def initialize(file_path, lint)
    @lines = []
    @lint = lint
    @file_string = File.read(file_path)
  end

  def violations?(meta = false)
    @file_string.split(/\n/).each_with_index do |line, number|
      @lint.line_too_long_violation?(line, number)
    end

    remove_multiline_strings!

    @file_string.each_with_index do |line, number|
      @lines << [line, number + 1]
    end

    @lines.each do |array|
      line, number = array
      @lint.violation?(line, number)
      @lint.exception_violation?(line, number)
      @lint.meta_violation?(line, number) if meta
    end

    if @lint.errors.any?
      display_errors if ARGV.include?("check")
      true
    else
      false
    end
  end

  def remove_multiline_strings!
    @file_string = @file_string.gsub(/\n/, UniqueConstant)
    @file_string = @lint.strip_multiline_strings(@file_string)
    @file_string = @file_string.gsub(/#{UniqueConstant}/, "#{UniqueConstant}\n")
    @file_string = @file_string.split(/#{UniqueConstant}/)
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

if ARGV[0] == 'check' && ARGV[-1] =~ /\.rb/
  meta = ARGV.include?("-m")
  FileParser.new(ARGV[-1], Lint.new).violations?(meta)
end
