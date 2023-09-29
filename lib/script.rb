require './lib/classes.rb'

board = Board.new()
player1 = Player.new("X")
player2 = Player.new("O")

already_placed = {
  X: [],
  O: []}

puts(board.coordinates_grid.map { |line| line.join })
puts "\n\n"
board.print_grid

switch_index = 0
9.times do
  current_player = switch_index.even? ? player1 : player2
  coordinates = 0
  loop do
    puts "Player #{current_player.symbol} enter your coordinates (1-9)"
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
