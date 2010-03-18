class Model
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
    winning_row? @grid, symbol or           # check row
    winning_row? @grid.transpose, symbol or # check column
                                            # check diagonal
    winning_row? [[@grid[0][0],@grid[1][1],@grid[2][2]],[@grid[0][2],@grid[1][1],@grid[2][0]]], symbol ? true : false
  end
  
  protected
  def winning_row? test_grid, symbol
    test_grid.map { |row| row.all? {|mark| mark == symbol } }.any?
  end
end