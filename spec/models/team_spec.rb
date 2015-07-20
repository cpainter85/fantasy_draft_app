require 'rails_helper'

describe Team do
  let(:game) { create(:game) }
  let(:user) { create(:user) }
  let!(:team) { create(:team, user: user, game: game) }

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
      it 'returns the picks belonging to a team' do
        picks = create_list(:pick, 10, team: team)
        expect(team.picks.order(:id)).to eq(picks)
      end
    end
  end

  describe 'validations' do
    it 'must have a name' do
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
    it 'validates the presence of a game' do
      team.update_attributes(game_id: nil)
      expect(team.errors.messages).to eq(game: ['must exist'])

      team.update_attributes(game_id: game.id+100)
      expect(team.errors.messages).to eq(game: ['must exist'])
    end
    it 'validates the presence of a user' do
      team.update_attributes(user_id: nil)
      expect(team.errors.messages).to eq(user: ['must exist'])

      team.update_attributes(user_id: user.id+100)
      expect(team.errors.messages).to eq(user: ['must exist'])
    end
  end

  describe 'methods' do
    describe '#next_draft' do
      it 'returns the number for the next available draft order number' do
        new_team = build(:team, game: game)
        new_team.next_draft
        new_team.save

        expect(new_team.draft_order).to eq(2)

        third_team = build(:team, game: game)
        third_team.next_draft
        third_team.save

        expect(third_team.draft_order).to eq(3)
      end
    end
  end
end
