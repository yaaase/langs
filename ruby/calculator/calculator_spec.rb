require './calculator'

describe Calculator do

  context "#add" do

    it "can add 1 + 1" do
      Calculator.add(1,1).should == 2
    end

    it "can add 1 + 2" do
      Calculator.add(1,2).should == 3
    end

    it "can add 1 + 1 + 2" do
      Calculator.add(1,1,2).should == 4
    end

    it "can add 1 + 2 + 3 + 4 + 5" do
      Calculator.add(1,2,3,4,5).should == 15
    end

  end

  context "#multiply" do

    it "can multiply 2 * 3" do
      Calculator.multiply(2,3).should == 6
    end

    it "can multiply 3 * 3" do
      Calculator.multiply(3,3).should == 9
    end

  end

end
