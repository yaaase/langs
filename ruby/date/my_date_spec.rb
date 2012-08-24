require './my_date'

describe MyDate do
  context "date logic" do
    context "subtraction" do
      it "days between feb 3 and feb 1 is 2" do
        (MyDate.new(:feb,3,2012) - MyDate.new(:feb,1,2012)).should == 2
      end

      it "days between feb 1 and jan 30 is 2" do
        (MyDate.new(:feb,1,2012) - MyDate.new(:jan,30,2012)).should == 2
      end

      it "days between mar 1 and jan 31 is 29" do
        (MyDate.new(:mar,1,2012) - MyDate.new(:jan,31,2012)).should == 30
      end

      it "days between apr 1 and jan 31 is 61" do
        (MyDate.new(:apr,1,2012) - MyDate.new(:jan,31,2012)).should == 61
      end

      it "days between jan 1 2012 and nov 30 2011 is 32" do
        (MyDate.new(:jan,1,2012) - MyDate.new(:nov,30,2011)).should == 32
      end

      it "days between jan 1 2012 and nov 30 2010 is 397" do
        (MyDate.new(:jan,1,2012) - MyDate.new(:nov,30,2010)).should == 397
      end
    end

    context "equality" do
      it "knows when dates are equal" do
        MyDate.new(:feb,3,2012).should == MyDate.new(:feb,3,2012)
      end

      it "knows when dates are not equal" do
        MyDate.new(:feb,3,2012).should_not == MyDate.new(:feb,3,2011)
      end
    end

    context "order" do
      it "jan is before feb" do
        (MyDate.new(:jan,1,2012) < MyDate.new(:feb,1,2012)).should be_true
      end

      it "feb is not before jan" do
        (MyDate.new(:feb,1,2012) < MyDate.new(:jan,1,2012)).should be_false
      end

      it "2012 is greater than 2011" do
        (MyDate.new(:mar,1,2012) > MyDate.new(:jan,1,2011)).should be_true
      end

      it "2011 is not greater than 2012" do
        (MyDate.new(:jan,1,2011) > MyDate.new(:mar,1,2012)).should be_false
      end
    end

    context "months" do
      it "two months between january and april" do
        MyDate.new(:apr,1,2012).send(:months_between,:jan).should ==
          [:feb,:mar]
      end

      it "six months between march and october" do
        MyDate.new(:oct,1,2012).send(:months_between,:mar).should ==
          [:apr,:may,:jun,:jul,:aug,:sep]
      end
    end

    context "days left or remaining in year" do
      it "on dec 30, 1 day is left" do
        (MyDate.new(:dec,30,2012).send(:days_til_end_of_year)).
          should == 1
      end

      it "on nov 30, 31 days left" do
        (MyDate.new(:nov,30,2012).send(:days_til_end_of_year)).
          should == 31
      end

      it "on oct 30, 62 days left" do
        (MyDate.new(:oct,30,2012).send(:days_til_end_of_year)).
          should == 62
      end

      it "on jan 1, 1 day into year" do
        (MyDate.new(:jan,1,2012).send(:days_into_year)).
          should == 1
      end

      it "on feb 1, 32 days into year" do
        (MyDate.new(:feb,1,2012).send(:days_into_year)).
          should == 32
      end

      it "on mar 2 (leap year), 62 days into year" do
        (MyDate.new(:mar,2,2012).send(:days_into_year)).
          should == 62
      end
    end

    context "leap year" do
      it "2012 is a leap year" do
        MyDate.new(:jan,1,2012).leap_year?.should be_true
      end

      it "2011 is not a leap year" do
        MyDate.new(:jan,1,2011).leap_year?.should be_false
      end

      it "2000 is a leap year" do
        MyDate.new(:jan,1,2000).leap_year?.should be_true
      end

      it "1700 is not a leap year" do
        MyDate.new(:jan,1,1700).leap_year?.should be_false
      end
    end

    context "day is before or after leap day within that year" do
      it "jan 1 2012 is not after a leap day" do
        (MyDate.new(:jan,1,2012).send(:after_leap_day?)).
          should be_false
      end

      it "feb 28 2012 is not after a leap day" do
        (MyDate.new(:feb,28,2012).send(:after_leap_day?)).
          should be_false
      end

      it "mar 1 2012 is after a leap year" do
        (MyDate.new(:mar,1,2012).send(:after_leap_day?)).
          should be_true
      end

      it "jan 1 2012 is before a leap day" do
        (MyDate.new(:jan,1,2012).send(:before_leap_day?)).
          should be_true
      end

      it "feb 28 2012 is before a leap day" do
        (MyDate.new(:feb,28,2012).send(:before_leap_day?)).
          should be_true
      end

      it "mar 1 2012 is not before a leap day" do
        (MyDate.new(:mar,1,2012).send(:before_leap_day?)).
          should be_false
      end
    end

    context "using the correct hash of day lengths" do
      it "in 2012, feb has 29 days" do
        MyDate.new(:jan,1,2012).instance_variable_get(:@days_key)[:feb].
          should == 29
      end

      it "in 2011, feb has 28 days" do
        MyDate.new(:jan,1,2011).instance_variable_get(:@days_key)[:feb].
          should == 28
      end
    end

    context "crossing leap day within a year" do
      it "feb 28 to mar 1 crosses a leap day" do
        (MyDate.new(:mar,1,2012) - MyDate.new(:feb,28,2012)).
          should == 2
      end
    end

    context "crossing leap day across years" do
      it "dec 31 2011 to mar 1 2012 is 61 days" do
        (MyDate.new(:mar,1,2012) - MyDate.new(:dec,31,2011)).should == 61
      end

      it "dec 31 2011 to feb 29 2012 is 60" do
        (MyDate.new(:feb,29,2012) - MyDate.new(:dec,31,2011)).should == 60
      end

      it "dec 31 2011 to feb 28 2012 is 59" do
        (MyDate.new(:feb,28,2012) - MyDate.new(:dec,31,2011)).should == 59
      end

      it "crosses leap year mar 1 2012 - dec 31 2010 is 426" do
        (MyDate.new(:mar,1,2012) - MyDate.new(:dec,31,2010)).should == 426
      end

      it "crosses leap mar 1 2011 to dec 31 2007 is 1156" do
        (MyDate.new(:mar,1,2011) - MyDate.new(:dec,31,2007)).should == 1156
      end
    end
  end

  context "to_s" do
    it "prints january nicely" do
      MyDate.new(:jan,1,2012).to_s.
        should == "January 1, 2012"
    end

    it "prints october nicely too" do
      MyDate.new(:oct,20,1982).to_s.
        should == "October 20, 1982"
    end
  end

  context "exceptions" do
    context "subtraction" do
      it "will not subtract a lower date from a higher one" do
        expect{MyDate.new(:mar,1,2012) - MyDate.new(:apr,1,2012)}.
          to raise_error SubtractionError
      end
    end

    context "initialization" do
      it "will not accept invalid date input" do
        expect{MyDate.new(:jan,"foo",2012)}.to raise_error
      end

      it "will not accept a day less than 1" do
        expect{MyDate.new(:jan,0,2012)}.to raise_error
      end

      it "will not accept a day outside of the date range" do
        expect{MyDate.new(:jan,40,2012)}.to raise_error
      end

      it "will not accept invalid month input" do
        expect{MyDate.new("foo",1,2012)}.to raise_error
      end

      it "will not accept invalid year format" do
        expect{MyDate.new(:jan,1,"123a")}.to raise_error
      end
    end
  end
end
