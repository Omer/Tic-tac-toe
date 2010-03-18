require 'helper'

describe Helper do
  include Helper
  
  it "should check whether an input is numeric" do
    is_numeric?("lol").should == false
    is_numeric?("1").should   == true
    is_numeric?(1).should     == true
  end
end