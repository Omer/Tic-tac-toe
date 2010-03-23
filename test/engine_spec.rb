require 'test/spec_helper'

describe Engine do
  before(:all) do 
    @engine = Engine.instance
  end
  
  it "should check whether it is a valid turn" do
    @engine.send(:valid_square?, 1, 1).should be_true
    @engine.send(:valid_square?, 3, 0).should be_false
  end
end