require 'rails_helper'

describe User do
  let (:user) { create_user }

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
end