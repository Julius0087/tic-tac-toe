class Board
  def initialize()
    @grid = [
      [' ', ' ', ' ', '|', ' ', ' ', ' ', '|', ' ', ' ', ' '],
      ['-', '-', '-', '|', '-', '-', '-', '|', '-', '-', '-'],
      [' ', ' ', ' ', '|', ' ', ' ', ' ', '|', ' ', ' ', ' '],
      ['-', '-', '-', '|', '-', '-', '-', '|', '-', '-', '-'],
      [' ', ' ', ' ', '|', ' ', ' ', ' ', '|', ' ', ' ', ' ']
    ]
    @coordinates_grid = [
      [' ', '1', ' ', '|', ' ', '2', ' ', '|', ' ', '3', ' '],
      ['-', '-', '-', '|', '-', '-', '-', '|', '-', '-', '-'],
      [' ', '4', ' ', '|', ' ', '5', ' ', '|', ' ', '6', ' '],
      ['-', '-', '-', '|', '-', '-', '-', '|', '-', '-', '-'],
      [' ', '7', ' ', '|', ' ', '8', ' ', '|', ' ', '9', ' ']
    ]
    @winning_combinations = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 5, 9],
      [3, 5, 7],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9]
    ]
  end

  attr_accessor :grid, :coordinates_grid, :winning_combinations

  def update_grid(symbol, coordinates)
    @coordinates_grid.each_with_index do |line, index|
      row = line.index(coordinates)
      unless row.nil?
        @grid[index][row] = symbol
      end
    end
  end

  def print_grid
    puts(self.grid.map { |x| x.join })
  end
end

class Player
  def initialize(symbol)
    @symbol = symbol
  end

  attr_reader :symbol

  def play_turn(coordinates, board, already_placed)
    board.update_grid(@symbol, coordinates)
  end

  def check_for_win(already_placed, board)
    board.winning_combinations.each do |combination|
      result = already_placed[@symbol.to_sym].intersection(combination)
      if result.sort == combination
        return true
      end
    end
  end
end
