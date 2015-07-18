require 'rails_helper'

describe Team do
  let (:game) { create_game }
  let (:user) { create_user }
  let! (:team) { create_team(game, user) }

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
    describe '#picks' do
      let (:position) { create_position(game) }
      let (:position2) { create_position(game, name: 'Lead in a Comedy') }
      let (:pick) { create_pick(team, position) }
      let (:pick2) { create_pick(team, position2) }

      it 'returns the picks belonging to a team' do
        expect(team.picks).to eq([pick, pick2])
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

  describe 'methods' do
    describe '#next_draft' do
      it 'returns the number for the next available draft order number' do
        new_team = Team.new(game_id: game.id, name: 'The Titans')
        new_team.next_draft
        new_team.save

        expect(Team.last.draft_order).to eq(2)

        third_team = Team.new(game_id: game.id, name: 'Teen Titans')
        third_team.next_draft
        third_team.save

        expect(Team.last.draft_order).to eq(3)
      end
    end
  end
end
