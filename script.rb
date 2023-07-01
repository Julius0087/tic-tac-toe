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

  attr_accessor :grid, :coordinates_grid

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

  def play_turn(coordinates, board)
    board.update_grid(@symbol, coordinates)
  end
end


board = Board.new()
player1 = Player.new("X")
player2 = Player.new("O")

already_placed = []

puts(board.coordinates_grid.map { |line| line.join })
puts(board.grid.map { |x| x.join })

9.times do
  current_player = player1
  coordinates = 0
  loop do
    puts "Enter your coordinates (1-9)"
    input = gets.chomp.to_i
    if input > 9 || input < 1
      puts "Invalid coordinates"
    elsif already_placed.include?(input)
      puts 'Already placed'
    else
      coordinates = input
      break
    end
  end
  current_player.play_turn(coordinates.to_s, board)
  already_placed.push(coordinates)

  board.print_grid
end
