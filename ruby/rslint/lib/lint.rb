class Lint
  attr_reader :errors

  Violations = {
    /def (self\.)?\w+ .\w+/ => :missing_parens,
    /.{80}+/               => :line_too_long,
    /( )+$/                => :trailing_whitespace
  }

  CommentedLine = [
    /^\s*#/
  ]

  MetaprogrammingViolations = {
    /\beval/            => :eval,
    /define_method/     => :define_method,
    /\w+\.send.*".*#\{/ => :dynamic_invocation
  }

  Messages = {
    :missing_parens      => "You have omitted parentheses from a method definition with parameters.",
    :line_too_long       => "Line length of 80 characters or more.",
    :trailing_whitespace => "Trailing whitespace.",
    :eval                => "Use of eval.",
    :define_method       => "Use of define_method.",
    :dynamic_invocation  => "Dynamic invocation of a method."
  }

  def initialize
    @errors = []
  end

  def violation?(line, number = 1)
    abstract_violation?(Violations, line, number)
  end

  def meta_violation?(line, number = 1)
    abstract_violation?(MetaprogrammingViolations, line, number)
  end

  def abstract_violation?(list, line, number)
    list.each do |pattern, error|
      CommentedLine.each do |comment|
        return false if line[comment]
      end

      if line[pattern]
        @errors << { error => number }
        return true
      end
    end
    return false
  end
  private :abstract_violation?

  def method_missing(method, *args, &block)
    if Messages.keys.include?(method.to_sym)
      Messages[method]
    else
      super(method, *args, &block)
    end
  end

end
