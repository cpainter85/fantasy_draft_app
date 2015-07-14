require 'rails_helper'

describe Team do
  let (:game) { create_game }
  let (:user) { create_user }
  let (:team) { create_team(game, user) }

  describe 'associations' do
    describe '#game' do
      it 'returns the game the team belongs to' do
        expect(team.game).to eq(game)
      end
    end
    describe '#user' do
      it 'returns the user the team belongs to' do
        expect(team.user).to eq(user)
      end
    end
  end

  describe 'validations' do
    it 'validates the presence of a team name' do
      team.update_attributes(name: nil)
      expect(team.errors.messages).to eq(name: ['can\'t be blank'])
    end
    it 'validates a team name is no more than 50 characters long' do
      team_name = 'text'*13
      team.update_attributes(name: team_name)
      expect(team.errors.messages).to eq(name: ['is too long (maximum is 50 characters)'])
    end
    it 'validates the presence of a draft order number' do
      team.update_attributes(draft_order: nil)
      expect(team.errors.messages).to eq(draft_order: ['can\'t be blank'])
    end
  end
end
