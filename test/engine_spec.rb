require 'test/spec_helper'

describe Engine do
  before(:all) do 
    @engine = Engine.instance
    @model  = Model.instance
    
    @player = Player.new "Alice"
  end
  
  after(:each) do
    @model.clear_grid
    Player.clear_instances
  end
  
  it "should check whether it is a valid turn" do
    @engine.send(:valid_turn?, 0, 0).should be_true
    @engine.send(:valid_turn?, 3, 0).should be_false
    @model.mark @player.symbol, 0, 0
    @engine.send(:valid_turn?, 0, 0).should be_false
  end
end