require './my_time'

describe MyTime do
  context "conversion and equality" do
    it "knows that 1 minute == 60 seconds" do
      MyTime.new(1,:m).should == MyTime.new(60,:s)
    end

    it "knows that 1 minute != 30 seconds" do
      MyTime.new(1,:m).should_not == MyTime.new(30,:s)
    end

    it "knows that 1 hour is 60 minutes" do
      MyTime.new(1,:h).should == MyTime.new(60,:m)
    end

    it "knows that 1 day is 24 hours" do
      MyTime.new(1,:d).should == MyTime.new(24,:h)
    end
  end

  context "exceptions" do
    it "will not accept invalid units" do
      expect{MyTime.new(1,:x)}.to raise_error
    end
  end
end
