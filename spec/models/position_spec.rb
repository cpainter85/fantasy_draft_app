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
    describe '#picks' do
      let (:user) { create_user }
      let (:user2) { create_user(email: 'dragonball@email.com')}
      let (:team) { create_team(game, user) }
      let (:team2) { create_team(game, user, name: 'The Super Saiyans') }
      let (:pick) { create_pick(team, position) }
      let (:pick2) { create_pick(team2, position) }

      it 'returns all the picks for a particular position' do
        expect(position.picks).to eq([pick, pick2])
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
