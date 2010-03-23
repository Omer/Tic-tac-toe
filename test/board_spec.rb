require 'test/spec_helper'

describe Board do
  before(:all) do 
    @board = Board.new
  end
  
  before(:each) do
    @player  = Player.new("Alice")
    @player2 = Player.new("Bob")
  end
  
  after(:each) do
    @board.clear_grid
    Player.clear_instances
  end
  
  it "should let to clear the grid" do
    @board.mark @player.symbol, 0, 0
    @board.clear_grid
    @board.marked?(0,0).should be_false
  end
  
  it "should let a player to mark the grid" do
    @board.mark @player.symbol, 0, 0
    @board.marked?(0,0).should be_true
  end
  
  it "should return the symbol of a square owner" do
    @board.mark @player.symbol, 0, 0
    @board.get_symbol(0,0).should eql(@player.symbol)
  end
  
  it "should let to check whether a given player won or not" do
    @board.mark @player.symbol, 0, 0
    @board.mark @player.symbol, 0, 1
    @board.mark @player.symbol, 0, 2
    @board.victory?(@player.symbol).should be_true
    @board.victory?(@player2.symbol).should be_false
  end
  
  it "should check whether the grid is full or not" do
    
    @board.mark @player.symbol, 0, 0
    @board.mark @player.symbol, 0, 1
    @board.mark @player2.symbol, 0, 2
    @board.mark @player2.symbol, 1, 0
    @board.mark @player2.symbol, 1, 1
    @board.mark @player.symbol, 1, 2
    @board.mark @player.symbol, 2, 0
    @board.mark @player.symbol, 2, 1
    @board.grid_full?.should be_false
    @board.mark @player2.symbol, 2, 2
    @board.grid_full?.should be_true
  end
end