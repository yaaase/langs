require_relative '../lib/file_parser'

describe FileParser do
  context "pass" do
    before(:each) do
      @string = "/home/mark/langs/ruby/rslint/txt/sample_1.rb"
      @f = FileParser.new(@string, Lint.new)
    end

    it "grabs a file with its line numbers" do
      @f.lines[0].should == ["class Foo\n", 1]
    end

    it "checks the file for errors" do
      @f.violations?.should be_false
    end
  end

  context "fail" do
    before(:each) do
      @string = "/home/mark/langs/ruby/rslint/txt/sample_fail.rb"
      @f = FileParser.new(@string, Lint.new)
    end

    it "knows when something has failed" do
      @f.violations?.should be_true
    end
  end
end
