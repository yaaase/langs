require './spec'
require 'test/unit'

class SpecTest < Test::Unit::TestCase

  def test_that_it_can_describe
    describe "foo" do
      it "bar" do
        2.should == 2
      end
    end
  end

  def test_that_it_can_fail
    assert_raise AssertionError do
      describe "bar" do
        it "fails" do
          raise AssertionError
        end
      end
    end
  end

  def test_should_can_fail
    assert_raise AssertionError do
      describe "failure" do
        it "fails again" do
          1.should == 2
        end
      end
    end
  end

  def test_should_not_can_pass
    describe "inequality" do
      it "gotta pass" do
        1.should_not == 2
      end
    end
  end

  def test_should_not_can_fail_too
    assert_raise AssertionError do
      describe "equality" do
        it "gonna fail" do
          2.should_not == 2
        end
      end
    end
  end

  def test_should_takes_and_calls_a_block
    describe "raise_error" do
      it "raises error" do
        2.foo.should raise_error
      end
    end
  end

end
