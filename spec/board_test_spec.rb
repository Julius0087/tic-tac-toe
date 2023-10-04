require './lib/classes.rb'
# require './lib/script.rb'

describe Board do
  describe '#update_grid' do
    subject(:board_check) { described_class.new }

    context 'when the symbol is "X"' do

      it 'updates the grid with the given symbol' do
        board_check.update_grid('X', 1)
        expect(board_check.grid[0][1]).to eq('X')
      end
    end

    context 'when the symbol is "O"' do
      it 'updates the grid with the given symbol' do
        board_check.update_grid('O', 2)
        expect(board_check.grid[0][5]).to eq('O')
      end
    end
  end

  describe '#update_placed' do
    subject(:placed_check) { described_class.new }

    context 'when adding to the "X" key' do
      it 'updates the hash with the coordinates' do
        placed_check.update_placed('X', 5)
        expect(placed_check.already_placed[:X]).to include(5)
      end
    end

    context 'when adding to the "O" key' do
      it 'updates the hash with the coordinates' do
        placed_check.update_placed('O', 6)
        expect(placed_check.already_placed[:O]).to include(6)
      end
    end
  end

  describe '#already_placed?' do
    subject(:board_placed) { described_class.new }
    context 'when the input is already placed' do
      
      before do
        board_placed.already_placed[:X] << 7
        # allow(board_placed).to receive(already_placed?).with(7).and_return(true)
      end

      it 'returns true' do
        placed_input = 7
        result = board_placed.already_placed?(placed_input)
        expect(result).to eq(true)
      end
    end
  end
end
