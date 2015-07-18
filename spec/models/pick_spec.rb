require 'rails_helper'

describe Pick do
  let(:game) { create_game }
  let(:user) { create_user }
  let(:team) { create_team(game,user) }
  let(:position) { create_position(game) }
  let(:pick) { create_pick(team, position) }

  describe 'associations' do
    describe '#team' do
      it 'returns the picks belonging to a team' do
        expect(pick.team).to eq(team)
      end
    end
    describe '#position' do
      it 'returns the position the pick is for' do
        expect(pick.position).to eq(position)
      end
    end
  end

  describe 'validations' do
    it 'validates the presence of a pick name' do
      pick.update_attributes(name: nil)
      expect(pick.errors.messages).to eq(name: ['can\'t be blank'])
    end
    it 'validates a pick name is no more than 50 characters long' do
      pick_name = 'name' * 13
      pick.update_attributes(name: pick_name)
      expect(pick.errors.messages).to eq(name: ['is too long (maximum is 50 characters)'])
    end
    it 'validates the from field is no more than 75 characters long' do
      pick_from = 'movie'*16
      pick.update_attributes(from: pick_from)
      expect(pick.errors.messages).to eq(from: ['is too long (maximum is 75 characters)'])
    end
    it 'validates the presence of a team' do
      pick.update_attributes(team_id: nil)
      expect(pick.errors.messages).to eq(team: ['can\'t be blank'])

      pick.update_attributes(team_id: team.id + rand(100))
      expect(pick.errors.messages).to eq(team: ['can\'t be blank'])
    end
    it 'validates the presence of a position' do
      pick.update_attributes(position_id: nil)
      expect(pick.errors.messages).to eq(position: ['can\'t be blank'])

      pick.update_attributes(position_id: position.id+rand(100))
      expect(pick.errors.messages).to eq(position: ['can\'t be blank'])
    end
  end

end
