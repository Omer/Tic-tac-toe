require 'test/spec_helper'

describe Player do
  include TicTacToeSpecHelper
  
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
  
  it "should allow only two players" do
    lambda {Player.new("Bob")}.should_not raise_error
    lambda {Player.new("Bill")}.should raise_error
  end
  
  it "should be converted to a readable string" do
    @player.to_s.should == "Alice (X)"
  end
  
  it "should be seachable by symbol" do
    Player.find_by_symbol(:X).should equal(@player)
  end
  
  it "should be seachable by name" do
    Player.find_by_name("Alice").should equal(@player)
  end
  
  it "should test for unique name" do
    lambda{Player.new("Alice")}.should raise_error
  end
  
  it "should test for unique symbol" do
    Player.new("Bob").symbol.should_not eql(@player.symbol) 
  end
  
  it "should be able to cycle over all existing players" do
    player2 = Player.new("James")
    Player.find_next.should equal(@player)
    Player.find_next.should equal(player2)
    Player.find_next.should equal(@player)
  end
  
  it "should count the number of victories" do
    @model.mark @player.symbol, 0, 0
    @model.mark @player.symbol, 0, 1
    @model.mark @player.symbol, 0, 2
    lambda {@player.victory! if @model.victory? @player.symbol}.should increase {@player.victories}
  end
end