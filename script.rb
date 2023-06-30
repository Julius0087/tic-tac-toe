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
  end

  attr_reader :grid, :coordinates_grid

  def update_grid(symbol, coordinates)
    
  end
end

class Player
  def initialize(symbol)
    @symbol = symbol
  end

  def play_turn(coordinates, board)
    board.update_grid(self.symbol, coordinates)

  end
end


board = Board.new()
player1 = Player.new("X")
player2 = Player.new("O")

puts board.coordinates_grid.map { |line| line.join }
puts board.grid.map { |x| x.join }

9.times do
  current_player = player1
  coordinates = 0
  loop do
    puts "Enter your coordinates (1-9)"
    input = gets.chomp.to_i
    if input > 9 || input < 1
      puts "Invalid coordinates"
      # add already placed handling
    else
      coordinates = input 
      break
    end
  end
  current_player.play_turn(coordinates, board)
end
