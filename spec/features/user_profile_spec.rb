require 'rails_helper'

feature 'User can see a profile page' do
  let (:user) { create(:user) }

  scenario 'user can view their profile' do
    user_sign_in(user)
    click_link user.name

    expect(current_path).to eq user_path(user)
    within 'div#profile-info' do
      expect(page).to have_content user.name
      expect(page).to have_content user.email
    end
  end
end
