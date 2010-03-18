require 'model'
require 'player'

describe Model do
  before(:all) do 
    @model = Model.instance
    @player = Player.new("Bob","O")
  end
  
  before(:each) do
    @model.clear_grid
    @model.marked?(0,0).should == false
  end
  
  it "should let to clear the grid" do
    @model.mark @player.symbol, 0, 0
    @model.clear_grid
    @model.marked?(0,0).should == false
  end
  
  it "should let a player to mark the grid" do
    @model.mark @player.symbol, 0, 0
    @model.marked?(0,0).should == true
  end
  
  it "should return the symbol of a square owner" do
    @model.mark @player.symbol, 0, 0
    @model.owner(0,0).should   == @player.symbol
  end
  
  it "should let to check if a given player won" do
    @model.mark @player.symbol, 0, 0
    @model.mark @player.symbol, 0, 1
    @model.mark @player.symbol, 0, 2
    @model.victory?(@player.symbol).should == true
  end
  
  it "should let to check if a given player not won" do
    @model.mark @player.symbol, 0, 0
    @model.mark @player.symbol, 0, 1
    @model.mark @player.symbol, 1, 2
    @model.victory?(@player.symbol).should == false
  end
end