require 'engine'

class ConsoleInterface
	def initialize
		@engine = Engine.instance
		@engine.interface = self
		@state = Array.new(3).map! {Array.new(3)}
	end
	
	def start
		@engine.get_players
		@engine.start_game
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
		(get_input[0..2].split ',').map {|s| s.to_i}
	end
	
	def get_player i
		puts "Enter player #{i} name and symbol:"
		name, symbol = get_input.split ','
		puts "\n"
		return name.strip, symbol.strip
	end
	
	def get_input
		input = gets
		exit if input == "exit\n" or input == "quit\n"
		input
	end
	
	def invalid_move row, column
		puts "Invalid move, try again.\n"
	end
	
	def exit
		system 'clear'
		Process.exit
	end
	
	def print_grid
		puts "\n" + (@state.map {|row| row.map {|i| i.nil? ? " " : i.to_s}.join " | "}.join "\n--+---+--\n") + "\n\n"
	end
end