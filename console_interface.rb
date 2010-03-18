require 'engine'
require 'player'

class ConsoleInterface
	def initialize
		@engine = Engine.instance
		@engine.interface = self
		@state = Array.new(3).map! {Array.new(3)}
	end
	
	def start
		@engine.get_players
		begin
		  system 'clear'
		  @engine.start_game
		  puts "\nNew game?"
		  exit if get_input =~ /no|n/i
		end until false
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
		begin
			name, symbol = gets.split ','
			puts "Please enter name as `Name, Symbol`:" if name.nil? or symbol.nil?
		end until !name.nil? and !symbol.nil?
		puts "\n"
		return name.strip, symbol.strip
	end
	
	def get_input
		input = gets
		exit  if input == "exit\n" or input == "quit\n"
		if input == "stats\n"
			stats
			update :pre_turn
			input = get_input
		end
		input
	end
	
	def invalid_move row, column
		puts "Invalid move, try again.\n"
	end
	
	def stats
	  puts "\n--- Game Statistics ---\n\n"
	  puts "Games played so far: #{@engine.games.count}"
	  Player.find_all.each {|player| puts "#{player.name} won #{player.victories}"}
	  puts "-----------------------\n\n"
  	end
	
	def exit
		system 'clear'
		Process.exit
	end
	
	def print_grid
		puts "\n" + (@state.map {|row| row.map {|i| i.nil? ? " " : i.to_s}.join " | "}.join "\n--+---+--\n") + "\n\n"
	end
end