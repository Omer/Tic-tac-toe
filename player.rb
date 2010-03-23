class Player
  attr_reader :name, :symbol, :victories
  
  @@players         = []
  @@players_cycle   = nil
  @@default_symbols = nil
 
  def initialize name
    raise ArgumentError, 'A player with that name already exists' unless self.class.find_by(:name, name).nil?
    
    @@default_symbols ||= [:X, :O].cycle
    @@players.push self
    @@players_cycle = @@players.cycle
    
    raise 'A game can have only two players' if @@players.count > 2

    @name      = name
    @symbol    = @@default_symbols.next
    @victories = 0
  end
  
  def victory!
  	@victories += 1
  end
  
  def to_s
  	"#{@name} (#{@symbol})"
  end
  
  def self.clear_instances
  	@@players         = []
  	@@players_cycle   = nil
  	@@default_symbols = nil
  end
  
  def self.find_all
  	@@players
  end
  
  def self.find_next
  	raise 'No players to cycle' if @@players_cycle.nil?
    @@players_cycle.next
  end
  
  def self.find_by symbol, param
    found = nil
    @@players.each { |player| found = player if player.send(symbol) == param }
    found
  end
end