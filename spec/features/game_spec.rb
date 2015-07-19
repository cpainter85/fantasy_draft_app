require 'rails_helper'

feature 'Users can create new games, view existing games, and join existing games' do
  let (:user) { create_user }

  scenario 'a signed in user can create a new game' do
    user_sign_in(user)
    new_game = {name: 'Comic Character Draft',
                description: 'A fantasy draft of comic book characters'}
    position_array = ["Lead Character (Drama)",
                      "Lead Character (Comedy)",
                      "Supporting Character (Drama)",
                      "Supporting Character (Comedy)",
                      "Cartoon Character"]

    visit root_path
    click_link 'Create New Game'

    expect(current_path).to eq new_game_path
    expect(page).to have_content 'Create a New Game'
    fill_in 'Name of Game', with: new_game[:name]
    fill_in 'Description', with: new_game[:description]

    fill_in 'Positions', with: position_array.join("\n")
    fill_in 'Team Name', with: 'The Champions'
    click_button 'Create Game'

    expect(current_path).to eq root_path
    expect(page).to have_content "#{new_game[:name]} successfully created!"
    expect(page).to have_content "#{new_game[:name]} (1 team) - #{position_array.length} Rounds"
    expect(Game.last.users).to eq([user])
    expect(Game.last.positions.last.name).to eq('Cartoon Character')
  end

  scenario 'a non-signed in user cannot create a new game' do
    visit root_path
    click_link 'Create New Game'

    expect(current_path).to eq sign_in_path
    expect(page).to have_content 'You must sign in'
  end

  scenario 'a signed in user can join an existing game' do
    game = create_game
    team = create_team(game, user)
    user2 = create_user(name: 'Captain America', email: 'sentinelofliberty@email.com')
    user_sign_in(user2)

    visit root_path
    expect(page).to have_content "#{game.name} (1 team)"
    click_link 'Join this game'

    expect(current_path).to eq new_game_team_path(game)
    expect(page).to have_content "Join #{game.name}"
    fill_in 'Team Name', with: 'The Squadron Supreme'
    click_button 'Join Game'

    expect(page).to have_content "You have successfully joined #{game.name}!"
    expect(page).to have_content "#{game.name} (2 teams)"
    expect(game.teams.count).to eq(2)
    expect(Team.last.user).to eq(user2)
    expect(Team.last.game).to eq(game)
    expect(Team.last.draft_order).to eq(game.teams.count)
    expect(page).to have_no_content('Join this game')
  end

  scenario 'a non-signed in user cannot join a game' do
    game = create_game

    visit root_path
    click_link 'Join this game'

    expect(current_path).to eq sign_in_path
    expect(page).to have_content 'You must sign in'

  end

end
