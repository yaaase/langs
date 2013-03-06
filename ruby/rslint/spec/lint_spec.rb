require_relative '../lib/lint'

describe Lint do
  let(:l) { Lint.new }

  context "#violation?" do
    context "missing_parens" do
      it "wants parens around method definitions with args" do
        l.violation?("def foo bar, baz").should be_true
      end

      it "does not need parens for methods with no args" do
        l.violation?("def some_method").should be_false
      end

      it "using parens is good" do
        l.violation?("def foo(bar, baz)").should be_false
      end

      it "using parens for methods with bang is the same" do
        l.violation?("def foo!").should be_false
      end

      it "a bang method with args needs parens too" do
        l.violation?("def foo! bar").should be_true
      end

      it "a question mark method without args is fine" do
        l.violation?("def foo?").should be_false
      end

      it "a question mark method with args needs parens" do
        l.violation?("def foo? bar").should be_true
      end

      it "class methods with bang+no args are fine" do
        l.violation?("def self.foo!").should be_false
      end

      it "class methods with bang+args need parens" do
        l.violation?("def self.foo! bar").should be_true
      end

      it "class methods with qmark+no args are fine" do
        l.violation?("def self.foo?").should be_false
      end

      it "class methods with qmark+args need parens" do
        l.violation?("def self.foo? bar").should be_true
      end

      it "positive case for bang" do
        l.violation?("def foo!(bar)").should be_false
      end

      it "positive case for class method bang" do
        l.violation?("def self.foo!(bar)").should be_false
      end

      it "positive case for qmark" do
        l.violation?("def foo?(bar)").should be_false
      end

      it "positive case for class method qmark" do
        l.violation?("def self.foo?(bar)").should be_false
      end

      it "acts the same for class methods" do
        l.violation?("def self.something foo, bar").should be_true
      end

      it "no parens for class methods without args is fine too" do
        l.violation?("def self.something").should be_false
      end

      it "arrays of args too need parens in the method def" do
        l.violation?("def foo *args").should be_true
      end
    end

    context "line_too_long" do
      it "dislikes lines of >= 80 chars" do
        l.line_too_long_violation?("#{'a' * 80}").should be_true
      end
    end

    context "trailing_whitespace" do
      it "whitespace at the end of the line is a no-no" do
        l.violation?("def foo(bar) ").should be_true
      end

      it "a newline is ok by itself" do
        l.violation?("\n").should be_false
      end
    end

    context "and and or" do
      it "the word 'and' is banned" do
        l.violation?("foo and bar").should be_true
      end

      it "the word 'or' is also banned" do
        l.violation?("1 or nil").should be_true
      end
    end

    context "for loops" do
      it "generally you should not use for loops" do
        l.violation?("for x in list do").should be_true
      end
    end

    context "multiline if then" do
      it "should not use then in multiline if" do
        l.violation?("if foo then\nbar\nend").should be_true
      end

      it "single line if then end is ok" do
        l.violation?("if true then false end").should be_false
      end
    end

    context "comments" do
      it "ignores comments" do
        l.violation?("# a comment").should be_false
      end

      it "ignores comments even when they otherwise violate the rules" do
        l.violation?("# def foo bar").should be_false
      end

      it "does not care what violation the comment breaks" do
        l.violation?("# and or def foo bar, baz").should be_false
      end

      it "ignores indented comments" do
        l.violation?(" # def foo bar").should be_false
      end

      it "ignores comments indented with tabs" do
        l.violation?("\t# def foo bar").should be_false
      end
    end
  end

  context "#meta_violation?" do
    it "can optionally check for metaprogramming" do
      l.meta_violation?("eval").should be_true
    end

    it "fucking HATES define_method" do
      l.meta_violation?("define_method").should be_true
    end

    it "dynamic method invocation via send is bad, mmkay?" do
      l.meta_violation?('foo.send "foo_#{:bar}"').should be_true
    end
  end

  context "#exception_violation?" do
    it "rescuing Exception is bad" do
      l.exception_violation?("rescue Exception").should be_true
    end

    it "rescuing nothing is the same as rescuing Exception" do
      l.exception_violation?("rescue    ").should be_true
    end
  end

  context "error messages" do
    it "keeps track of your mistakes and their lines, defaulting to line #1" do
      l.violation?("def foo bar")
      l.errors.first.values.should == [1]
    end

    it "knows what line number you fucked up on" do
      l.violation?("def foo bar", 3)
      l.errors.first.values.should == [3]
    end

    it "everything has an error message" do
      expect do
        Lint::Violations.values.each do |violation|
          Lint::Messages.fetch(violation)
        end
        Lint::ExceptionViolations.values.each do |exception_violation|
          Lint::Messages.fetch(exception_violation)
        end
        Lint::MetaprogrammingViolations.values.each do |metaprogramming_violation|
          Lint::Messages.fetch(metaprogramming_violation)
        end
      end.to_not raise_error
    end
  end

  context "#method_missing" do
    it "implements method_missing intelligently" do
      expect { l.foo }.to raise_error
    end
  end
end
