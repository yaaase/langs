require './foo'

describe Foo do

  it "takes multiple arguments" do
    expect{Foo.new(:a,:b,:c)}.to_not raise_error
  end

  it "knows if it has received an argument" do
    foo = Foo.new :a, :b, :c
    foo.contains?(:a).should be_true
  end

  it "stores methods it does not know" do
    foo = Foo.new
    expect{foo.something}.to raise_error(NoMethodError)
    foo.missed_methods.should == [:something]
  end

end
