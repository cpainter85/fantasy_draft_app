require 'rails_helper'

describe Game do
  let (:game) { create_game }

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
