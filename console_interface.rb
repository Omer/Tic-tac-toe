require 'engine'

class ConsoleInterface
	def initialize
		@engine = Engine.instance
		@state = Array.new(3).map! {Array.new(3)}
	end
	
	def update symbol, grid = nil
		@state = grid unless grid.nil?
		send symbol
	end
	
	def setup
		system 'clear'
		puts "--- Tic-Tac-Toe ---"
		puts "By Chris Connelly & Omer Jakobinsky\n\n"
	end
	
	def new_game
		puts "--- New Game ---\n\n"
	end
	
	def victory
		puts "\n\n#{@engine.current_player.name} won in #{@engine.turns} turns!\n\n"
	end
	
	def draw
		puts "\n\nPlayers draw!\n\n"
	end
	
	def pre_turn
		puts "#{@engine.current_player.name}'s turn:\n"
	end
	
	def post_turn
		print_grid
	end
	
	def get_move
		(gets[0..2].split ',').map {|s| s.to_i}
	end
	
	def print_grid
		puts @state.map {|row| row.map {|i| i.nil? ? " " : i.to_s}.join " | "}.join "\n--+---+--\n"
	end
end