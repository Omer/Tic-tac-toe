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
end