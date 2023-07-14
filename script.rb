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
    # TODO: find a way to compare the already_placed array with arrays that contain winning combinations
    board.winning_combinations.each do |combination|
      result = already_placed[@symbol.to_sym].intersection(combination)
      if result.sort == combination
        return true
      end
    end
  end
end


board = Board.new()
player1 = Player.new("X")
player2 = Player.new("O")

already_placed = {
  X: [],
  O: []}

puts(board.coordinates_grid.map { |line| line.join })
puts "\n\n"
puts(board.grid.map { |x| x.join })

switch_index = 0
9.times do
  current_player = switch_index.even? ? player1 : player2
  coordinates = 0
  loop do
    puts "Enter your coordinates (1-9)"
    input = gets.chomp.to_i
    if input > 9 || input < 1
      puts "Invalid coordinates"
    # better way to check for this? already placed as a class variable for each player?
    elsif already_placed[:X].include?(input) || already_placed[:O].include?(input)
      puts 'Already placed'
    else
      coordinates = input
      break
    end
  end
  result = current_player.play_turn(coordinates.to_s, board, already_placed)
  break if result == true

  already_placed[current_player.symbol.to_sym] << coordinates
  board.print_grid
  if current_player.check_for_win(already_placed, board) == true
    puts "#{current_player.symbol} has won!"
    exit
  end

  switch_index += 1
end
puts "It's a tie!"

