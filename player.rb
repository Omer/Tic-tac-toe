class Player
  attr_reader :name, :symbol
 
  def initialize name, symbol
    raise ArgumentError, 'An error has occured' unless self.class.find_by_name(name).nil?
    @name   = name
    raise ArgumentError, 'An error has occured' unless self.class.find_by_symbol(symbol).nil?
    @symbol = symbol
    @players_cycle = ObjectSpace.each_object(Player).cycle
  end
  
  def to_s
    "Name: " + @name + ", Symbol: " + @symbol
  end
  
  def self.find_next
    @players_cycle.next
  end
  
  def self.find_by_symbol symbol
    found = nil
    ObjectSpace.each_object(Player) { |player| found = player if player.symbol == symbol }
    found
  end
  
  def self.find_by_name name
    found = nil
    ObjectSpace.each_object(Player) { |player| found = player if player.name == name }
    found
  end
end