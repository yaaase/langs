require_relative '../lib/lint'

describe Lint do
  let(:l) { Lint.new }

  it "wants parens around method definitions with args" do
    l.violation?("def foo bar, baz").should be_true
  end

  it "does not need parens for methods with no args" do
    l.violation?("def some_method").should be_false
  end

  it "acts the same for class methods" do
    l.violation?("def self.something foo, bar").should be_true
  end

  it "no parens for class methods without args" do
    l.violation?("def self.something").should be_false
  end

  it "has methods with text explaining what is bad" do
    l.missing_parens.should == "You have omitted parentheses from a method definition with parameters."
  end

  it "implements method_missing intelligently" do
    expect { l.foo }.to raise_error
  end

  it "keeps track of your mistakes and their lines, defaulting to line #1" do
    l.violation?("def foo bar")
    l.errors.should == [{:missing_parens => 1}]
  end

  it "knows what line number you fucked up on" do
    l.violation?("def foo bar", 3)
    l.errors.should == [{:missing_parens => 3}]
  end

  it "dislikes lines of >= 80 chars" do
    l.violation?("#{'a' * 80}").should be_true
  end

  it "knows why it dislikes them too" do
    l.line_too_long.should == "Line length of 80 characters or more."
  end

  it "can optionally check for metaprogramming" do
    l.meta_violation?("eval").should be_true
  end

  it "fucking HATES define_method" do
    l.meta_violation?("define_method").should be_true
  end

  it "whitespace at the end of the line is a no-no" do
    l.violation?("def foo(bar) ").should be_true
  end

  it "a newline is ok by itself" do
    l.violation?("\n").should be_false
  end

  it "ignores comments" do
    l.violation?("# a comment").should be_false
  end

  it "ignores comments even when they otherwise violate the rules" do
    l.violation?("# def foo bar").should be_false
  end

  it "ignores indented comments" do
    l.violation?(" # def foo bar").should be_false
  end

  it "ignores comments indented with tabs" do
    l.violation?("\t# def foo bar").should be_false
  end
end
