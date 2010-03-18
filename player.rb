class Player
  attr_accessor :name, :symbol
 
  def initialize name, symbol
    @name   = name
    @symbol = symbol
  end
  
  def to_s
    "Name: " + @name + ", Symbol: " + @symbol
  end
  
  def self.find_by_symbol(symbol)
    found = nil
    ObjectSpace.each_object(Player) { |player| found = player if player.symbol == symbol }
    found
  end
end