require 'rails_helper'

feature 'User can signup' do
  scenario 'allow a user to sign up with valid credentials' do
    visit root_path

    expect(page).to have_content 'Sign Up'
    expect(page).to have_no_content 'Sign Out'

    click_link 'Sign Up'
    expect(current_path).to eq sign_up_path

    expect(page).to have_content 'New User Sign Up'
    fill_in 'Name', with: 'Superman'
    fill_in 'Email', with: 'manofsteel@email.com'
    fill_in 'Password', with: 'lastsonofkrypton'
    fill_in 'Password confirmation', with: 'lastsonofkrypton'
    click_button 'Sign Up'

    expect(current_path).to eq root_path
    expect(page).to have_content 'You have successfully signed up!'
    expect(page).to have_content 'Superman'
    expect(page).to have_content 'Sign Out'
  end

  scenario 'User cannot sign up with invalid credentials' do
    visit sign_up_path
    click_button 'Sign Up'

    expect(page).to have_no_content 'You have successfully signed up!'
    expect(page).to have_content 'Name can\'t be blank'
    expect(page).to have_content 'Email can\'t be blank'
    expect(page).to have_content 'Password can\'t be blank'
    expect(page).to have_no_content 'Sign Out'
  end
end
