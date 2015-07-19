require 'rails_helper'

describe Pick do
  let(:game) { create_game }
  let(:user) { create_user }
  let(:team) { create_team(game,user) }
  let(:position) { create_position(game) }
  let!(:pick) { create_pick(team, position) }

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

      pick.update_attributes(team_id: team.id + 100)
      expect(pick.errors.messages).to eq(team: ['can\'t be blank'])
    end
    it 'validates the presence of a position' do
      pick.update_attributes(position_id: nil)
      expect(pick.errors.messages).to eq(position: ['can\'t be blank'])

      pick.update_attributes(position_id: position.id+100)
      expect(pick.errors.messages).to eq(position: ['can\'t be blank'])
    end
    it 'validates the presence of round drafted' do
      pick.update_attributes(round_drafted: nil)
      expect(pick.errors.messages).to eq(round_drafted: ['can\'t be blank'])
    end
    it 'validates that a single team can only make one pick per round' do
      position2 = create_position(game, name: 'Cartoon Character')
      pick2 = Pick.new(team_id: team.id, position_id: position2.id, name: 'Homer Simpson', from: 'The Simpsons', round_drafted: 1)
      pick2.save
      expect(pick2.errors.messages).to eq(round_drafted: ['has already been filled on your team'])

      user2 = create_user(email: 'greenlantern@email.com')
      team2 = create_team(game, user2, name: 'The Green Lantern Corps')
      pick3 = create_pick(team2, position)
      expect(pick3.errors.any?).to eq(false)
    end
    it 'validates that a position can only be drafted once per team' do
      pick2 = Pick.new(team_id: team.id, position_id: position.id, name: 'Tony Soprano', from: 'The Sopranos', round_drafted: 2)
      pick2.save
      expect(pick2.errors.messages).to eq(position: ['has already been filled on your team'])

      user2 = create_user(email: 'greenlantern@email.com')
      team2 = create_team(game, user2, name: 'The Green Lantern Corps')
      pick3 = create_pick(team2, position)
      expect(pick3.errors.any?).to eq(false)
    end
  end

end
