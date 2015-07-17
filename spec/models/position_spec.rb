require 'rails_helper'

describe Position do
  let(:game) { create_game }
  let(:position) { create_position(game) }

  describe 'associations' do
    describe '#game' do
      it 'returns the game the position belongs to' do
        expect(position.game).to eq(game)
      end
    end
  end

  describe 'validations' do
    it 'validates the presence of a position name' do
      position.update_attributes(name: nil)
      expect(position.errors.messages).to eq(name: ['can\'t be blank'])
    end
    it 'validates a position name is no more than 50 characters long' do
      position_name = 'name'*13
      position.update_attributes(name: position_name)
      expect(position.errors.messages).to eq(name: ['is too long (maximum is 50 characters)'])
    end
  end
end
