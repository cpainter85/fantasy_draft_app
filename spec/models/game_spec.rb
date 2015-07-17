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

    describe '#positions' do
      let(:position) { create_position(game) }
      let(:position2) { create_position(game, name: 'Lead Character in a Comedy')}

      it 'returns all the positions in a game' do
        expect(game.positions).to eq([position, position2])
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

  describe 'methods' do

      let(:position_array) { ["Lead Character (Drama)",
                        "Lead Character (Comedy)",
                        "Supporting Character (Drama)",
                        "Supporting Character (Comedy)",
                        "Cartoon Character"] }

    describe '#create_positions' do
      it 'creates positions to be used in this game' do

        game.create_positions(position_array.join("\n"))
        expect(game.positions.count).to eq(position_array.length)
        expect(game.positions.last.name).to eq(position_array.last)
      end
    end
    describe '#rounds' do
      it 'shows the number of rounds in a game' do
        position_array.each do |position|
          create_position(game, name: position)
        end
        expect(game.rounds).to eq(position_array.length)
      end
    end
  end

end
