require 'engine'
require 'model'
require 'player'

class ConsoleInterface
	def initialize
		@engine = Engine.instance
		@engine.interface = self
	end
	
	def start
		@engine.get_players
		begin
		  system 'clear'
		  @engine.start_game
		  stats
		  
		  puts "\nNew game?"
		  exit if get_input =~ /no|n/i
		end until false
	end
	
	def update symbol
		send symbol
	end
	
	def setup
		system 'clear'
		puts "--- Tic-Tac-Toe ---"
		puts "By Chris Connelly & Omer Jakobinsky\n\n"
	end
	
	def new_game
		puts "--- New Game ---\n"
		print_grid
	end
	
	def victory
		puts "\n\n#{@engine.current_player.name} won in #{@engine.turns} turns!\n\n"
	end
	
	def draw
		puts "\n\nPlayers draw!\n\n"
	end
	
	def pre_turn
		puts "#{@engine.current_player.name}'s turn:"
	end
	
	def post_turn
		print_grid
	end
	
	def get_move
		(get_input[0..2].split ',').map {|s| s.to_i - 1 }
	end
	
	def get_player i
		puts "Enter player #{i} name:"
		begin
		  (input = gets) == "\n" ? name = "Player #{i}" : name = input
			puts "Please reenter the name:" if name.nil?
		end until !name.nil?
		puts "\n"
		return name.strip
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
	
	def invalid_move row, column, marked
		puts (marked ? "That square is already taken\n" : "Invalid move, enter move as 'row,column'.\n")
	end
	
	def stats
	  puts "\n--- Game Statistics ----\n\n"
	  puts "Games played so far: #{@engine.games.count}"
	  Player.find_all.each {|player| puts "#{player.to_s} won #{player.victories}"}
	  puts "------------------------\n\n"
  	end
	
	def exit
		system 'clear'
		Process.exit
	end
	
	def print_grid
		puts "\n" + (Model.instance.grid.map {|row| "  " + (row.map {|i| i.nil? ? " " : i.to_s}.join " | ")}.join "\n ---+---+---\n") + "\n\n"
	end
end