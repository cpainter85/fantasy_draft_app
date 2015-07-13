require 'rails_helper'

feature 'User sign in' do
  scenario 'User can sign in with valid credentials' do
    user = create_user

    visit root_path
    expect(page).to have_no_content 'Sign Out'

    click_link 'Sign In'
    expect(current_path).to eq sign_in_path
    expect(page).to have_content 'Sign In Page'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(current_path).to eq root_path
    expect(page).to have_content 'You have successfully signed in!'
    expect(page).to have_content user.name
    expect(page).to have_content 'Sign Out'
  end

  scenario 'User cannot sign in with invalid credentials' do
    visit sign_in_path
    click_button 'Sign In'

    expect(current_path).to eq sign_in_path
    expect(page).to have_content 'Invalid Email/Password combination'
    expect(page).to have_no_content 'You have successfully signed in!'
    expect(page).to have_no_content 'Sign Out'
  end
end
