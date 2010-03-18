require 'singleton'

class Model
  include Singleton
  
  def initialize
    clear_grid  # initialise multidimensional array to store the marks.
  end
  
  # marks a given square on the grid.
  def mark symbol, row, column 
    marked?(row,column) ? false : @grid[row][column] = symbol
  end
  
  # check whether a square have been marked.
  def marked? row, column 
    @grid[row][column].nil? ? false : true
  end
  
  # return the symbol in a given square.
  def owner row, column
    marked?(row,column) ? @grid[row][column] : false
  end
  
  # clear the grid from all the marks.
  def clear_grid
    @grid = Array.new(3).map! { Array.new(3) } 
  end
  
  def victory? symbol
    winning_row? @grid, symbol or           		# check row
    winning_row? @grid.transpose, symbol or 		# check column
    (0..2).map {|i| @grid[i][i] == symbol}.all? or  # check diagonals
    (0..2).map {|i| @grid[i][2-i] == symbol}.all?
  end
  
  # check whether the grid is full or not.
  def grid_full?
  	(0..2).map {|i| (0..2).map {|j| marked? i, j}.all?}.all?
  end
  
  protected
  def winning_row? test_grid, symbol
    test_grid.map { |row| row.all? {|mark| mark == symbol } }.any?
  end
end