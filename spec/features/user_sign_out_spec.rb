require 'rails_helper'

feature 'User sign out' do
  scenario 'User can sign out' do
    user = create(:user)
    user_sign_in(user)

    visit root_path
    expect(page).to have_content user.name

    click_link 'Sign Out'
    expect(current_path).to eq root_path
    expect(page).to have_content 'You have successfully signed out!'
    expect(page).to have_content 'Sign In'
    expect(page).to have_no_content 'Sign Out'
    expect(page).to have_no_content user.name
  end
end
