class Lint
  attr_reader :errors

  Violations = {
    /def (self\.)?\w+[!?]? .\w+/ => :missing_parens,
    /.{80}+/                     => :line_too_long,
    /( )+$/                      => :trailing_whitespace,
    /\band\b/                    => :the_word_and,
    /\bor\b/                     => :the_word_or,
    /\bfor\b/                    => :the_word_for
  }

  ExceptionViolations = {
    /rescue\s*(Exception)?$/ => :rescue_class_exception
  }

  MetaprogrammingViolations = {
    /\beval/            => :eval,
    /define_method/     => :define_method,
    /\w+\.send.*".*#\{/ => :dynamic_invocation
  }

  CommentedLine = [
    /^\s*#/
  ]

  Messages = {
    :missing_parens         => "You have omitted parentheses from a method definition with parameters.",
    :line_too_long          => "Line length of 80 characters or more.",
    :trailing_whitespace    => "Trailing whitespace.",
    :eval                   => "Use of eval.",
    :define_method          => "Use of define_method.",
    :dynamic_invocation     => "Dynamic invocation of a method.",
    :rescue_class_exception => "Rescuing class Exception.",
    :the_word_and           => "Used 'and'; please use && instead.",
    :the_word_or            => "Used 'or'; please use || instead.",
    :the_word_for           => "Used 'for'; please use an enumerator, or else explain yourself adequately to the team."
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

  def exception_violation?(line, number = 1)
    abstract_violation?(ExceptionViolations, line, number)
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

  def method_missing(method_name, *args, &block)
    if Messages.keys.include?(method_name.to_sym)
      Messages[method_name]
    else
      super(method_name, *args, &block)
    end
  end

end
