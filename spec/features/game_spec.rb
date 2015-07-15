require 'rails_helper'

feature 'Users can create new games, view existing games, and join existing games' do
  let (:user) { create_user }

  scenario 'a signed in user can create a new game' do
    user_sign_in(user)
    new_game = {name: 'Comic Character Draft',
                description: 'A fantasy draft of comic book characters'}

    visit root_path
    click_link 'Create New Game'

    expect(current_path).to eq new_game_path
    expect(page).to have_content 'Create a New Game'
    fill_in 'Name of Game', with: new_game[:name]
    fill_in 'Description', with: new_game[:description]
    fill_in 'Team Name', with: 'The Champions'
    click_button 'Create Game'

    expect(current_path).to eq root_path
    expect(page).to have_content "#{new_game[:name]} successfully created!"
    expect(page).to have_content "#{new_game[:name]} (1 team)"
    expect(Game.last.users).to eq([user])
  end
end
