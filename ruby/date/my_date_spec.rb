require './my_date'

describe MyDate do
  context "date logic" do
    it "days between feb 3 and feb 1 is 2" do
      (MyDate.new(:feb,3,2012) - MyDate.new(:feb,1,2012)).should == 2
    end

    it "knows when dates are equal" do
      MyDate.new(:feb,3,2012).should == MyDate.new(:feb,3,2012)
      MyDate.new(:feb,3,2012).should_not == MyDate.new(:feb,3,2011)
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

    it "knows how many days left in a year" do
      (MyDate.new(:dec,30,2012).send(:days_til_end_of_year)).
        should == 1
      (MyDate.new(:nov,30,2012).send(:days_til_end_of_year)).
        should == 32
      (MyDate.new(:oct,30,2012).send(:days_til_end_of_year)).
        should == 63
    end

    it "knows how many days into the year" do
      (MyDate.new(:jan,1,2012).send(:days_into_year)).
        should == 0
      (MyDate.new(:feb,1,2012).send(:days_into_year)).
        should == 31
      (MyDate.new(:feb,2,2012).send(:days_into_year)).
        should == 32
      (MyDate.new(:mar,2,2012).send(:days_into_year)).
        should == 60
    end

    it "days between jan 1 2012 and nov 30 2011 is 32" do
      (MyDate.new(:jan,1,2012) - MyDate.new(:nov,30,2011)).should == 32
    end

    it "days between jan 1 2012 and nov 30 2010 is 397" do
      (MyDate.new(:jan,1,2012) - MyDate.new(:nov,30,2010)).should == 397
    end

    it "knows when is a leap year" do
      MyDate.new(:jan,1,2012).leap_year?.should be_true
      MyDate.new(:jan,1,2011).leap_year?.should be_false
      MyDate.new(:jan,1,2000).leap_year?.should be_true
      MyDate.new(:jan,1,1700).leap_year?.should be_false
      MyDate.new(:jan,1,1600).leap_year?.should be_true
      MyDate.new(:jan,1,1996).leap_year?.should be_true
    end
  end

  context "exceptions" do
    it "will not subtract a lower date from a higher one" do
      expect{MyDate.new(:mar,1,2012) - MyDate.new(:apr,1,2012)}.
        to raise_error
      expect{MyDate.new(:mar,1,2011) - MyDate.new(:jan,1,2012)}.
        to raise_error
    end

    it "will not accept invalid date input" do
      expect{MyDate.new(:jan,0,2012)}.to raise_error
      expect{MyDate.new(:jan,40,2012)}.to raise_error
      expect{MyDate.new(:jan,"foo",2012)}.to raise_error
    end

    it "will not accept invalid month input" do
      expect{MyDate.new("foo",1,2012)}.to raise_error
    end

    it "will not accept invalid year format" do
      expect{MyDate.new(:jan,1,"123a")}.to raise_error
    end
  end
end
