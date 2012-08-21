require './my_date'

describe MyDate do
  context "date logic" do
    it "days between feb 3 and feb 1 is 2" do
      (MyDate.new(:feb,3,2012) - MyDate.new(:feb,1,2012)).should == 2
    end

    it "knows when dates are equal" do
      MyDate.new(:feb,3,2012).should == MyDate.new(:feb,3,2012)
    end

    it "knows the order of months" do
      (MyDate.new(:jan,1,2012) < MyDate.new(:feb,1,2012)).should be_true
      (MyDate.new(:feb,1,2012) < MyDate.new(:jan,1,2012)).should be_false
      (MyDate.new(:feb,1,2012) == MyDate.new(:feb,1,2012)).should be_true
    end

    it "days between feb 1 and jan 30 is 2" do
      (MyDate.new(:feb,1,2012) - MyDate.new(:jan,30,2012)).should == 2
      (MyDate.new(:feb,2,2012) - MyDate.new(:jan,30,2012)).should == 3
      (MyDate.new(:feb,2,2012) - MyDate.new(:jan,29,2012)).should == 4
    end

    it "knows the months between two months" do
      MyDate.new(:apr,1,2012).send(:months_between,:jan).should ==
        [:feb,:mar]
      MyDate.new(:oct,1,2012).send(:months_between,:mar).should ==
        [:apr,:may,:jun,:jul,:aug,:sep]
    end

    it "days between mar 1 and jan 31 is 29" do
      (MyDate.new(:mar,1,2012) - MyDate.new(:jan,31,2012)).should == 29
      (MyDate.new(:apr,1,2012) - MyDate.new(:jan,31,2012)).should == 60
    end

    it "knows which year is greater" do
      (MyDate.new(:mar,1,2012) > MyDate.new(:jan,1,2011)).should be_true
      (MyDate.new(:jan,1,2011) > MyDate.new(:mar,1,2012)).should be_false
      (MyDate.new(:jan,1,2011) == MyDate.new(:jan,1,2011)).should be_true
    end
  end

  context "exceptions" do
    it "will not subtract a lower date from a higher one" do
      expect{MyDate.new(:mar,1,2012) - MyDate.new(:apr,1,2012)}.
        to raise_error
    end

    it "will not accept invalid date input" do
      expect{MyDate.new(:jan,0,2012)}.to raise_error
      expect{MyDate.new(:jan,40,2012)}.to raise_error
      expect{MyDate.new(:jan,"foo",2012)}.to raise_error
    end

    it "will not accept invalid month input" do
      expect{MyDate.new(:foo,1,2012)}.to raise_error
    end

    it "will not accept invalid year format" do
      expect{MyDate.new(:jan,1,"123a")}.to raise_error
    end
  end
end
