require 'rails_helper'

describe Game do
  let (:game) { create_game }

  describe 'associations' do
    let(:user) { create_user }
    let(:user2) { create_user(name: 'Bruce Wayne', email: 'batman@email.com', password: 'thedarkknight')}
    let!(:team) { create_team(game, user) }
    let!(:team2) { create_team(game, user2, name: 'Justice League', draft_order: 2) }

    describe '#teams' do
      it 'returns all the teams participating in a particular game' do
        expect(game.teams).to eq([team, team2])
      end
    end

    describe '#users' do
      it 'returns all the users participating in a particular game' do
        expect(game.users).to eq([user, user2])
      end
    end
  end

  describe 'validations' do
    it 'validates the presence of a name' do
      game.update_attributes(name: nil)
      expect(game.errors.messages).to eq(name: ['can\'t be blank'])
    end

    it 'validates a description is less than 1500 characters' do
      text = 'text'*376
      game.update_attributes(description: text)
      expect(game.errors.messages).to eq(description: ['is too long (maximum is 1500 characters)'])
    end
  end

end
