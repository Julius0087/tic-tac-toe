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
    @already_placed = {
      X: [],
      O: []
    }
  end

  attr_accessor :grid, :coordinates_grid, :winning_combinations, :already_placed

  def update_grid(symbol, coordinates)
    @coordinates_grid.each_with_index do |line, row|
      column = line.index(coordinates.to_s)
      unless column.nil?
        @grid[row][column] = symbol
      end
    end
  end

  def update_placed(symbol, coordinates)
    @already_placed[symbol.to_sym] << coordinates
  end

  def print_grid(grid)
    puts(grid.map { |x| x.join })
  end

  def already_placed?(input)
    return true if @already_placed[:X].include?(input) || @already_placed[:O].include?(input)
  end
end

class Player
  def initialize(symbol)
    @symbol = symbol
  end

  attr_reader :symbol
end

class Game
  def initialize
    @board = Board.new
    @player_one = Player.new('X')
    @player_two = Player.new('O')
    @current_player = @player_two
  end

  def play
    introduction
    @board.print_grid(@board.grid)

    loop do
      @current_player = select_player
      currrent_symbol = @current_player.symbol

      puts "Player #{@current_player.symbol} enter your coordinates (1-9)"
      coordinates = get_input
      @board.update_grid(currrent_symbol, coordinates)
      @board.update_placed(currrent_symbol, coordinates)
      @board.print_grid(@board.grid)

      break if game_won?(currrent_symbol)
      break if tie?
    end
  end

  def select_player
    return @current_player == @player_one ? @player_two : @player_one
  end

  def get_input
    loop do
      player_input = gets.chomp
      verified_input = verify_input(player_input)
      
      if verified_input
        unless @board.already_placed?(verified_input.to_i)
          return verified_input.to_i
        else
          puts 'Input error. This place is already taken.'
        end
      else
        puts 'Input error. Select a number between 1 and 9.'
      end
    end
  end

  def verify_input(input)
    return input if input.match?(/^[1-9]$/)
  end

  def game_won?(symbol)
    @board.winning_combinations.each do |combination|
      result = @board.already_placed[symbol.to_sym].intersection(combination)
      if result.sort == combination
        puts "Player #{symbol} wins!"
        return true
      end
    end
    return false
  end

  def tie?
    num_of_moves_x = @board.already_placed[:X].length
    num_of_moves_o = @board.already_placed[:O].length
    if num_of_moves_o + num_of_moves_x >= 9
      puts "It's a tie!"
      return true
    end
  end

  def introduction
    puts <<~HEREDOC

      Welcome to Tic-tac-toe!

      Two players take turns to fill a 3x3 grid with their symbols.
      Players enter coordinates (1-9) to place their symbol into the desired spot.
      Player that has three consecutive symbols in a row, column or diagonally wins.
      Coordinates guide:
      
    HEREDOC
    @board.print_grid(@board.coordinates_grid)
    puts "\n\n"
  end
end




