require 'rails_helper'

describe Game do
  let (:game) { create(:game) }

  describe 'associations' do
    describe '#teams' do
      it 'returns all the teams participating in a particular game' do
        teams = create_list(:team, 10, game: game)
        expect(game.teams.order(:id)).to eq(teams)
      end
    end

    describe '#users' do
      it 'returns all the users participating in a particular game' do
        users = create_list(:user, 10)
        users.map {|user| create(:team, game: game, user: user)}
        expect(game.users.order(:id)).to eq(users)
      end
    end

    describe '#positions' do
      it 'returns all the positions in a game' do
        positions = create_list(:position, 10, game: game)
        expect(game.positions.order(:id)).to eq(positions)
      end
    end

    describe '#picks' do
      it 'returns all the picks in a particular game' do
        positions = create_list(:position, 10, game: game)
        teams = create_list(:team, 10, game: game)
        picks = teams.map.with_index {|team, index| create(:pick, team: team, position: positions[index]) }
        expect(game.picks.order(:id)).to eq(picks)
      end
    end

  end

  describe 'validations' do
    it 'must have a name' do
      game.update_attributes(name: nil)
      expect(game.errors.messages).to eq(name: ['can\'t be blank'])
    end

    it 'validates a description is less than 1500 characters' do
      game.update_attributes(description: 'text'*376)
      expect(game.errors.messages).to eq(description: ['is too long (maximum is 1500 characters)'])
    end
  end

  describe 'methods' do
    describe '#create_positions' do
      it 'creates positions to be used in this game' do
        position_array = (1..10).map {|x| Faker::Name.title }
        game.create_positions(position_array.join("\n"))
        expect(game.positions.count).to eq(position_array.length)
        expect(game.positions.order(:id).pluck(:name)).to eq(position_array)
      end
    end
    describe '#rounds' do
      it 'shows the number of rounds in a game' do
        create_list(:position, 10, game: game)
        expect(game.rounds).to eq(10)
      end
    end
  end

end
