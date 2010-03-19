require 'test/spec_helper'

describe Helper do
  include Helper
  
  it "should check whether an input is numeric" do
    is_numeric?("lol").should be_false
    is_numeric?("1").should be_true
    is_numeric?(1).should be_true
  end
end