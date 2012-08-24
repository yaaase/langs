require './parser'

describe Parser do

  context "month day year without commas" do
    it "January 1 2012 is a valid date object" do
      Parser.date("January 1 2012").
        should == MyDate.new(:jan,1,2012)
    end

    it "moonshine 1 2012 raises exception" do
      expect{Parser.date("moonshine 1 2012")}.
        to raise_error
    end
  end

  context "it's okay if you put commas in there too" do
    it "January 1, 2012 is a valid date object" do
      Parser.date("January 1, 2012").
        should == MyDate.new(:jan,1,2012)
    end
  end

  context "it also doesn't care if you say 1st, 2nd, 3rd, etc" do
    it "March 22nd, 2012 is a valid date object" do
      Parser.date("March 22nd, 2012").
        should == MyDate.new(:mar,22,2012)
    end
  end

  context "it doesn't care about order" do
    it "1 January, 2012 is a valid date object" do
      Parser.date("1 January, 2012").
        should == MyDate.new(:jan,1,2012)
    end

    it "2012, 1st October is legit as well" do
      Parser.date("2012, 1st October").
        should == MyDate.new(:oct,1,2012)
    end
  end

end
