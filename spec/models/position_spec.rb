require 'rails_helper'

describe Position do
  let(:game) { create(:game) }
  let(:position) { create(:position, game: game) }

  describe 'associations' do
    describe '#game' do
      it 'returns the game the position belongs to' do
        expect(position.game).to eq(game)
      end
    end
    describe '#picks' do
      it 'returns all the picks for a particular position' do
        teams = create_list(:team, 10, game: game)
        picks = teams.map {|team| create(:pick, position: position, team: team) }
        expect(position.picks.order(:id)).to eq(picks)
      end
    end
  end

  describe 'validations' do
    it 'validates the presence of a position name' do
      position.update_attributes(name: nil)
      expect(position.errors.messages).to eq(name: ['can\'t be blank'])
    end
    it 'validates a position name is no more than 50 characters long' do
      position.update_attributes(name: 'name'*13)
      expect(position.errors.messages).to eq(name: ['is too long (maximum is 50 characters)'])
    end
    it 'validates the presence of a game' do
      position.update_attributes(game_id: nil)
      expect(position.errors.messages).to eq(game: ['must exist'])

      position.update_attributes(game_id: game.id+100)
      expect(position.errors.messages).to eq(game: ['must exist'])
    end
  end
end
