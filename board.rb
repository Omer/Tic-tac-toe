class Board
  def initialize
    clear_grid  # initialise multidimensional array to store the marks.
  end
  
  # clear the grid from all the marks.
  def clear_grid
    @grid = Array.new(3).map! { Array.new(3) } 
  end
  
  # marks a given square on the grid.
  def mark symbol, row, column 
  	raise "Square #{row}, #{column} is already taken." if marked? row, column
    @grid[row][column] = symbol
  end
  
  # check whether a square has been marked.
  def marked? row, column
    @grid[row][column].nil? ? false : true
  end
  
  # return the symbol in a given square.
  def get_symbol row, column
    marked?(row,column) ? @grid[row][column] : false
  end
  
  # check whether the grid is full or not.
  def grid_full?
  	@grid.flatten.map {|symbol| !symbol.nil?}.all?
  end
  
  def victory? symbol
    winning_row? @grid, symbol or           		# check row
    winning_row? @grid.transpose, symbol or 		# check column
    winning_row? [(0..2).map {|index| @grid[index][index]}, (0..2).map {|index| @grid[index][2-index]}], symbol # check diagonals
  end
  
  protected
  def winning_row? test_grid, symbol
    test_grid.map { |row| row.all? {|mark| mark == symbol } }.any?
  end
end