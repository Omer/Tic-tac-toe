class Player
  attr_reader :name, :symbol
  
  @@players       = []
  @@players_cycle = nil
 
  def initialize name, symbol
    raise ArgumentError, 'A player with that name already exists' unless self.class.find_by_name(name).nil?
    raise ArgumentError, 'A player with that symbol already exists' unless self.class.find_by_symbol(symbol).nil?
    
    @name   = name
    @symbol = symbol
    
    @@players.push self
    @@players_cycle = @@players.cycle
  end
  
  def to_s
  	"Player: #{@name} (#{@symbol})"
  end
  
  def self.clear_instances
  	@@players = []
  	@@players_cycle = nil
  end
  
  def self.find_all
  	@@players
  end
  
  def self.find_next
  	raise 'No players to cycle' if @@players_cycle.nil?
    @@players_cycle.next
  end
  
  def self.find_by_symbol symbol
    found = nil
    @@players.each { |player| found = player if player.symbol == symbol }
    found
  end
  
  def self.find_by_name name
    found = nil
    @@players.each { |player| found = player if player.name == name }
    found
  end
end