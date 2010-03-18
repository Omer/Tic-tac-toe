require 'model'
require 'player'
require 'helper'
require 'singleton'

class Engine
	include Singleton, Helper
	
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
	
	def get_players
		name, symbol = @interface.get_player 1
		Player.new name, symbol
		
		name, symbol = @interface.get_player 2
		Player.new name, symbol
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
			@games.push [Player.find_by_symbol(@current_player.symbol).name, @turns]
      @current_player.victory!
			@interface.update :victory
		else
			@games.push ["Draw",@turns]
			@interface.update :draw
		end
	end
	
	protected
	def turn player
		begin
			@interface.update :pre_turn
			row, column = @interface.get_move
			@interface.invalid_move row, column unless valid_turn? row, column
		end until (valid_turn? row, column)
		
		Model.instance.mark @current_player.symbol, row, column
		@interface.update :post_turn, Model.instance.grid
	end

	def valid_turn? row, column
		is_numeric? row and is_numeric? column and
		row    <= 2     and row    >= 0        and
		column <= 2     and column >= 0        and
		!Model.instance.marked? row, column
	end
end