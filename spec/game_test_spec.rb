require './lib/classes.rb'

describe Game do

  describe '#initialize' do
    

    context 'when a new Game object is initialized' do
      before do
        allow(Board).to receive(:new)
        allow(Player).to receive(:new)
      end

      it 'sends a message that creates one board' do
        expect(Board).to receive(:new).once
        described_class.new
      end

      it 'sends a message that creates two players' do
        expect(Player).to receive(:new).twice
        described_class.new
      end
    end
  end

  describe '#get_input' do
    subject(:game_input) { described_class.new }

    context 'when a valid input is given' do

      before do
        valid_input = '6'
        allow(game_input).to receive(:verify_input).and_return(valid_input)
      end

      it 'stops the loop and does not display error message' do
        error_message = 'Input error. Select a number between 1 and 9.'
        expect(game_input).not_to receive(:puts).with(error_message)
        game_input.get_input
      end

    end

    context 'when an invalid and then valid input is given'

    before do
      valid_input = '7'
      invalid_input = nil
      allow(game_input).to receive(:verify_input).and_return(invalid_input, valid_input)
    end

    it 'completes loop and displays an error message once' do
      error_message = 'Input error. Select a number between 1 and 9.'
      expect(game_input).to receive(:puts).with(error_message).once
      game_input.get_input
    end
  end

  describe '#verify_input' do
    subject(:game_verify) { described_class.new }

    context 'when valid input is given' do

      it 'returns the valid input' do
        valid_input = '6'
        result = game_verify.verify_input(valid_input)
        expect(result).to eq('6')
      end
    end

    context 'when invalid input is given' do

      it 'returns nil' do
        invalid_input = 'h'
        result = game_verify.verify_input(invalid_input)
        expect(result).to be_nil
      end
    end
  end

  describe '#game_won?' do

    subject(:game_winning) { described_class.new }

    context 'when a winning combination is detected for X' do
      before do
        game_winning.instance_variable_get(:@board).already_placed[:X].push(1, 2, 3)
      end

      it 'returns true' do
        symbol = 'X'
        result = game_winning.game_won?(symbol)
        expect(result).to be true
      end

      it 'puts a correct message' do
        symbol = 'X'
        message = "Player #{symbol} wins!"
        expect(game_winning).to receive(:puts).with(message).once
        game_winning.game_won?(symbol)
      end
    end

    context 'when a winning combination is detected for O' do
      before do
        game_winning.instance_variable_get(:@board).already_placed[:O].push(3, 5, 7)
      end

      it 'returns true' do
        symbol = 'O'
        result = game_winning.game_won?(symbol)
        expect(result).to be true
      end

      it 'puts a correct message' do
        symbol = 'O'
        message = "Player #{symbol} wins!"
        expect(game_winning).to receive(:puts).with(message).once
        game_winning.game_won?(symbol)
      end
    end

    subject(:game_losing) { described_class.new }
    context 'when a non-winning combination is detected' do
      before do
        game_losing.instance_variable_get(:@board).already_placed[:X].push(1, 6, 8)
      end

      it 'returns false' do
        symbol = 'X'
        result = game_losing.game_won?(symbol)
        expect(result).to be false
      end
    end

  end
  
  describe '#tie?' do
    subject(:game_tie) { described_class.new }

    context 'when all coordinates have been placed' do
      before do
        game_tie.instance_variable_get(:@board).already_placed[:X].push(1, 4, 3, 6, 8)
        game_tie.instance_variable_get(:@board).already_placed[:O].push(2, 7, 5, 9)
      end

      it 'returns true' do
        result = game_tie.tie?
        expect(result).to be true
      end
    end

    context 'when some coordinates are still missing' do
      before do
        game_tie.instance_variable_get(:@board).already_placed[:X].push(1, 4, 6, 8)
        game_tie.instance_variable_get(:@board).already_placed[:O].push(2, 7, 5, 9)
      end

      it 'returns nil' do
        result = game_tie.tie?
        expect(result).to be_nil
      end
    end

  end

end

