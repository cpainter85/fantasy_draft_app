require 'rails_helper'

describe Pick do
  let(:team) { create(:team) }
  let(:position) { create(:position) }
  let(:pick) { create(:pick, team: team, position: position) }

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
      pick.update_attributes(name: 'name' * 13)
      expect(pick.errors.messages).to eq(name: ['is too long (maximum is 50 characters)'])
    end
    it 'validates the from field is no more than 75 characters long' do
      pick.update_attributes(from: 'movie'*16)
      expect(pick.errors.messages).to eq(from: ['is too long (maximum is 75 characters)'])
    end
    it 'validates the presence of a team' do
      pick.update_attributes(team_id: nil)
      expect(pick.errors.messages).to eq(team: ['must exist'])

      pick.update_attributes(team_id: team.id + 100)
      expect(pick.errors.messages).to eq(team: ['must exist'])
    end
    it 'validates the presence of a position' do
      pick.update_attributes(position_id: nil)
      expect(pick.errors.messages).to eq(position: ['must exist'])

      pick.update_attributes(position_id: position.id+100)
      expect(pick.errors.messages).to eq(position: ['must exist'])
    end
    it 'validates the presence of round drafted' do
      pick.update_attributes(round_drafted: nil)
      expect(pick.errors.messages).to eq(round_drafted: ['can\'t be blank'])
    end
    it 'validates that a single team can only make one pick per round' do
      pick2 = build(:pick, team: pick.team, round_drafted: pick.round_drafted)
      pick2.save
      expect(pick2.errors.messages).to eq(round_drafted: ['has already been filled on your team'])

      pick3 = create(:pick, round_drafted: pick.round_drafted)
      expect(pick3.errors.any?).to eq(false)
    end
    it 'validates that a position can only be drafted once per team' do
      pick2 = build(:pick, team: pick.team, position: pick.position)
      pick2.save
      expect(pick2.errors.messages).to eq(position: ['has already been filled on your team'])

      another_team_pick = create(:pick, position: pick.position)
      expect(another_team_pick.errors.any?).to eq(false)
    end
  end

end
