require 'model'
require 'player'
require 'singleton'

class Engine
	include Singleton
	
	attr_reader :games, :turns, :current_player
	
	def initialize
		@interface = nil
		@current_player = nil
		@games = []
		@turns = 0
	end
	
	def interface= i
		@interface = i
		@interface.update :setup
	end
	
	def start_game
		raise 'No interface set for engine' if @interface.nil?
		
		@interface.update :new_game
		@turns  = 0
		
		begin
			@current_player = Player.find_next
			turn @current_player
			@turns += 1
		end until (Model.instance.victory? @current_player.symbol) or Model.instance.grid_full?
		
		if Model.instance.victory? @current_player.symbol
			@games.push Player.find_by_symbol(@current_player.symbol).name
			@interface.update :victory
		else
			@games.push "Draw"
			@interface.update :draw
		end
	end
	
	protected
	def turn player
		@interface.update :pre_turn
		row, column = @interface.get_move
		Model.instance.mark @current_player.symbol, row, column
		@interface.update :post_turn, Model.instance.grid
	end
end