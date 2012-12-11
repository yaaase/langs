require_relative '../lib/connection'

describe Connection do

  before(:each) { @connection = Connection.new }

  it "receives a call to open-uri#open" do
    @connection.should_receive(:open).with('http://www.google.com')
    @connection.connected?
  end

  it "knows if it is connected" do
    @connection.stub(:open).and_return(true)
    @connection.connected?.should be_true
  end

  it "returns false if an exception is raised" do
    @connection.stub(:open).and_raise
    @connection.connected?.should be_false
  end

end
