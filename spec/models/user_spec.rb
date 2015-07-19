require 'rails_helper'

describe User do
  let (:user) { create_user }
  let(:game) { create_game }
  let!(:team) { create_team(game, user) }
  let(:game2) { create_game(name: 'Movie Draft', description: 'Fantasy draft of Movie characters') }

  describe 'associations' do
    let!(:team2) { create_team(game2, user) }

    describe '#teams' do
      it 'returns all the teams belongs to a particular user' do
        expect(user.teams).to eq([team, team2])
      end
    end
    describe '#games' do
      it 'returns all the games a user is participating in' do
        expect(user.games).to eq([game, game2])
      end
    end
  end

  describe 'validations' do
    it 'validates the presence of a name' do
      user.update_attributes(name: nil)
      expect(user.errors.messages).to eq(name: ['can\'t be blank'])
    end

    it 'validates the presence of an email' do
      user.update_attributes(email: nil)
      expect(user.errors.messages).to eq(email: ['can\'t be blank'])
    end

    it 'validates the uniqueness of an email' do
      user2 = User.new(name: 'Peter Parker', email: user.email, password: 'withgreatpower')
      user2.save
      expect(user2.errors.messages).to eq(email: ['has already been taken'])
    end

    it 'validates a password is at least 8 characters long' do
      user.update_attributes(password: '1234567')
      expect(user.errors.messages).to eq(password: ['is too short (minimum is 8 characters)'])
    end
  end

  describe 'methods' do
    describe '#particpant?' do
      it 'returns true if the user has a team in the game passed in' do
        expect(user.participant?(game)).to eq(true)
      end
      it 'returns false if the user does not have a team in the game' do
        expect(user.participant?(game2)).to eq(false)
      end
    end
  end
end
