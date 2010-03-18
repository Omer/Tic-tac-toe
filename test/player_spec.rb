require 'player'

describe Player do
  before(:all) do 
    @player = Player.new("Alice", "X")
  end
  
  it "should be converted to a readable string" do
    @player.to_s.should == "Name: Alice, Symbol: X"
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
end