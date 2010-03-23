require 'model'
require 'player'
require 'helper'
require 'singleton'

class Engine
	include Singleton, Helper
	
	attr_reader :games, :turns, :current_player
	
	def initialize
	  @model = Model.instance
		@interface = nil
		@current_player = nil
		@games = []
		@turns = 0
	end
	
	def interface= interface
		@interface = interface
		@interface.update :setup
	end
	
	def get_players
		Player.new (@interface.get_player 1)
		Player.new (@interface.get_player 2)
	end
	
	def start_game
		raise 'No interface set for engine' if @interface.nil?
		
		@interface.update :new_game
		@turns = 0
		
		begin
			@current_player = Player.find_next
			current_symbol = @current_player.symbol
			
			turn current_symbol
			@turns += 1
		end until (@model.victory? current_symbol) or @model.grid_full?
		
		if @model.victory? current_symbol
			@games.push [Player.find_by_symbol(current_symbol).name, @turns]
      @current_player.victory!
			@interface.update :victory
		else
			@games.push ["Draw",@turns]
			@interface.update :draw
		end
	end
	
	protected
	def turn symbol
		begin
			@interface.update :pre_turn
			row, column = @interface.get_move
			
			if valid_square? row, column
				@interface.invalid_move row, column, true if @model.marked? row, column
			else
				@interface.invalid_move row, column, false
			end
		end until (valid_square? row, column) and !@model.marked? row, column
		
		@model.mark symbol, row, column
		@interface.update :post_turn
	end
	
	def valid_square? row, column
	  is_numeric? row and is_numeric? column and
		row    <= 2     and row    >= 0        and
		column <= 2     and column >= 0
	end
end