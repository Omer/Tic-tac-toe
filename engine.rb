require 'board'
require 'player'
require 'helper'
require 'singleton'

class Engine
	include Singleton, Helper
	
	attr_reader :games, :turns, :current_player, :board
	
	def initialize
	  @board ||= Board.new
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
		begin
			Player.new (@interface.get_player 2)
		rescue ArgumentError
			@interface.handle_exception
		end until Player.find_all.count == 2
	end
	
	def start_game
		raise 'No interface set for engine' if @interface.nil?
		
		@interface.update :new_game
		@turns = 0
		
		begin
			@current_player = Player.find_next
			current_symbol = @current_player.symbol
			
			turn
			@turns += 1
		end until (@board.victory? current_symbol) or @board.grid_full?
		
		if @board.victory? current_symbol
			@games.push [Player.find_by_symbol(current_symbol).name, @turns]
      @current_player.victory!
			@interface.update :victory
		else
			@games.push ["Draw",@turns]
			@interface.update :draw
		end
	end
	
	protected
	def turn
		begin
			@interface.update :pre_turn
			if @current_player.respond_to? :get_move
				row, column = @current_player.get_move
			else
				row, column = @interface.get_move
			end
			
			if valid_square? row, column
				@interface.invalid_move row, column, true if @board.marked? row, column
			else
				@interface.invalid_move row, column, false
			end
		end until (valid_square? row, column) and !@board.marked? row, column
		
		@board.mark @current_player.symbol, row, column
		@interface.update :post_turn
	end
	
	def valid_square? row, column
	  is_numeric? row and is_numeric? column and
		row    <= 2     and row    >= 0        and
		column <= 2     and column >= 0
	end
end