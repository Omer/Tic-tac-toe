require 'player'
require 'model'

describe Player do
  before(:all) do 
    @model = Model.instance
    Player.clear_instances
    @player = Player.new("Alice", "X")
  end
  
  it "should be converted to a readable string" do
    @player.to_s.should == "Player: Alice (X)"
  end
  
  it "should be seachable by symbol" do
    Player.find_by_symbol("X").should == @player
  end
  
  it "should be seachable by name" do
    Player.find_by_name("Alice").should == @player
  end
  
  it "should test for unique name" do
    lambda{Player.new("Alice", "O")}.should raise_error
  end
  
  it "should test for unique symbol" do
    lambda{Player.new("Bob", "X")}.should raise_error
  end
  
  it "should be able to cycle over all existing players" do
    player2 = Player.new("James", "J")
    Player.find_next.should == @player
    Player.find_next.should == player2
    Player.find_next.should == @player
  end
  
  it "should count the number of victories so far" do
    @player.victories.should == 0
    @model.mark @player.symbol, 0, 0
    @model.mark @player.symbol, 0, 1
    @model.mark @player.symbol, 0, 2
    @player.victory! if @model.victory? @player.symbol 
    @player.victories.should == 1
  end
end