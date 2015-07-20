require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  describe 'associations' do
    describe '#teams' do
      it 'returns all the teams belongs to a particular user' do
        teams = create_list(:team, 5, user: user)
        expect(user.teams.order(:id)).to eq(teams)
      end
    end

    describe '#games' do
      it 'returns all the games a user is participating in' do
        games = create_list(:game, 5)
        games.map { |game| create(:team, user: user, game: game) }
        expect(user.games.order(:id)).to eq(games)
      end
    end

  end

  #
  describe 'validations' do
    it 'must have a name' do
      user.update_attributes(name: nil)
      expect(user.errors.messages).to eq(name: ['can\'t be blank'])
    end

    it 'validates the presence of an email' do
      user.update_attributes(email: nil)
      expect(user.errors.messages).to eq(email: ['can\'t be blank'])
    end

    it 'validates the uniqueness of an email' do
      user2 = build(:user, email: user.email)
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
        game = create(:game)
        team = create(:team, user: user, game: game)
        expect(user.participant?(game)).to eq(true)
      end
      it 'returns false if the user does not have a team in the game' do
        game2 = create(:game)
        expect(user.participant?(game2)).to eq(false)
      end
    end
  end
end
