require './parser'

describe Parser do
  context "basic parsing and object construction" do
    it "January 1 2012 is a valid date object" do
      Parser.date("January 1 2012").
        should == MyDate.new(:jan,1,2012)
    end

    it "moonshine 1 2012 raises exception" do
      expect{Parser.date("moonshine 1 2012")}.
        to raise_error
    end

    it "January 1, 2012 is a valid date object" do
      Parser.date("January 1, 2012").
        should == MyDate.new(:jan,1,2012)
    end
  end

  context "it doesn't care if you say 1st, 2nd, 3rd, etc" do
    it "March 22nd, 2012 is a valid date object" do
      Parser.date("March 22nd, 2012").
        should == MyDate.new(:mar,22,2012)
    end
  end

  context "it also doesn't care about order" do
    it "1 January, 2012 is a valid date object" do
      Parser.date("1 January, 2012").
        should == MyDate.new(:jan,1,2012)
    end

    it "2012, 1st October is legit as well" do
      Parser.date("2012, 1st October").
        should == MyDate.new(:oct,1,2012)
    end
  end

  context "integrated subtraction" do
    it "2012, 1 mar - february 1st 2012 is 29" do
      (Parser.date("2012, 1 mar") - Parser.date("february 1st 2012")).
        should == 29
    end
  end
end
