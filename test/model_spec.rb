require 'test/spec_helper'

describe Model do
  before(:all) do 
    @model = Model.instance
  end
  
  before(:each) do
    @player = Player.new "Alice"
  end
  
  after(:each) do
    @model.clear_grid
    Player.clear_instances
  end
  
  it "should let to clear the grid" do
    @model.mark @player.symbol, 0, 0
    @model.clear_grid
    @model.marked?(0,0).should be_false
  end
  
  it "should let a player to mark the grid" do
    @model.mark @player.symbol, 0, 0
    @model.marked?(0,0).should be_true
  end
  
  it "should return the symbol of a square owner" do
    @model.mark @player.symbol, 0, 0
    @model.owner(0,0).should eql(@player.symbol)
  end
  
  it "should let to check if a given player won" do
    @model.mark @player.symbol, 0, 0
    @model.mark @player.symbol, 0, 1
    @model.mark @player.symbol, 0, 2
    @model.victory?(@player.symbol).should be_true
  end
  
  it "should let to check if a given player not won" do
    @model.mark @player.symbol, 0, 0
    @model.mark @player.symbol, 0, 1
    @model.mark @player.symbol, 1, 2
    @model.victory?(@player.symbol).should be_false
  end
  
  it "should check whether the grid is full or not" do
    player2 = Player.new "Jim"
    @model.mark @player.symbol, 0, 0
    @model.mark @player.symbol, 0, 1
    @model.mark player2.symbol, 0, 2
    @model.mark player2.symbol, 1, 0
    @model.mark player2.symbol, 1, 1
    @model.mark @player.symbol, 1, 2
    @model.mark @player.symbol, 2, 0
    @model.mark @player.symbol, 2, 1
    @model.grid_full?.should be_false
    @model.mark player2.symbol, 2, 2
    @model.grid_full?.should be_true
  end
end