class Lint
  attr_reader :errors

  LineTooLongViolations = {
    /.{80}+/                     => :line_too_long
  }

  Violations = {
    /def (self\.)?\w+[!?]? .\w+/ => :missing_parens,
    /( )+$/                      => :trailing_whitespace,
    /\band\b/                    => :the_word_and,
    /\bor\b/                     => :the_word_or,
    /\bfor\b/                    => :the_word_for,
    /if.*then\n/                 => :multiline_if_then,
    /\(\s|\s\)/                  => :paren_spacing,
    /\[\s|\s\]/                  => :bracket_spacing,
    /[^\s][{}]|{[^\s]/           => :brace_spacing
  }

  ExceptionViolations = {
    /rescue\s*(Exception)?$/ => :rescue_class_exception
  }

  MetaprogrammingViolations = {
    /\beval\b/          => :eval,
    /\bclass_eval\b/    => :class_eval,
    /\bmodule_eval\b/   => :module_eval,
    /\binstance_eval\b/ => :instance_eval,
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
    :the_word_for           => "Used 'for'; please use an enumerator, or else explain yourself adequately to the team.",
    :multiline_if_then      => "Use of 'then' on a multiline if statement.",
    :class_eval             => "Use of class_eval.",
    :module_eval            => "Use of module_eval.",
    :instance_eval          => "Use of instance_eval.",
    :paren_spacing          => "Space after ( or before ).",
    :bracket_spacing        => "Space after [ or before ].",
    :brace_spacing          => "No space around { or before }."
  }

  def initialize
    @errors = []
  end

  def line_too_long_violation?(line, number = 1)
    abstract_violation?(LineTooLongViolations, line, number)
  end

  def violation?(line, number = 1)
    line = stripped_of_strings(line)
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

  def stripped_of_strings(line)
    line.gsub(/".*"/, '""').gsub(/'.*'/, "''")
  end

  def method_missing(method_name, *args, &block)
    if Messages.keys.include?(method_name.to_sym)
      Messages[method_name]
    else
      super(method_name, *args, &block)
    end
  end

end
