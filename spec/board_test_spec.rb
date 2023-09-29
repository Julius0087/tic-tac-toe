require './lib/classes.rb'
require './lib/script.rb'

describe Board do
  describe '#update_grid' do
    subject(:board_check) { described_class.new }

    context 'when the symbol is "X"' do

      it 'updates the grid with the given symbol' do
        grid = board_check.grid
        expect(grid[0][1]).to eq('X')
        board_check.update_grid('X', 1)
      end
    end
  end
end
