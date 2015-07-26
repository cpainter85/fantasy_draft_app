require 'rails_helper'

feature 'Users can create new games, view existing games, and join existing games' do
  let (:user) { create(:user) }

  scenario 'a signed in user can create a new game' do
    user_sign_in(user)
    new_game = { name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph }
    position_array = (1..10).map { |x| Faker::Name.title }

    visit root_path
    click_link 'Create New Game'

    expect(current_path).to eq new_game_path
    expect(page).to have_content 'Create a New Game'
    fill_in 'Name of Game', with: new_game[:name]
    fill_in 'Description', with: new_game[:description]

    fill_in 'Positions', with: position_array.join("\n")
    fill_in 'Team Name', with: Faker::Team.name
    click_button 'Create Game'

    expect(current_path).to eq root_path
    expect(page).to have_content "#{new_game[:name]} successfully created!"
    expect(page).to have_content "#{new_game[:name]}"
    expect(page).to have_content "Rounds: #{position_array.length}"
    expect(page).to have_content "Teams: 1"
    expect(page).to have_content "Description: #{new_game[:description]}"
    expect(Game.last.users).to eq([user])
    expect(Game.last.positions.order(:id).pluck(:name)).to eq(position_array)
  end

  scenario 'a non-signed in user cannot create a new game' do
    visit root_path
    click_link 'Create New Game'

    expect(current_path).to eq sign_in_path
    expect(page).to have_content 'You must sign in'
  end

  scenario 'a signed in user can join an existing game' do
    game = create(:game)
    team = create(:team, game: game, user: user)
    user2 = create(:user)

    user_sign_in(user2)

    visit root_path
    expect(page).to have_content "#{game.name}"
    click_link 'Join game'

    expect(current_path).to eq new_game_team_path(game)
    expect(page).to have_content "Join #{game.name}"
    fill_in 'Team Name', with: Faker::Team.name
    click_button 'Join Game'

    expect(page).to have_content "You have successfully joined #{game.name}!"
    expect(page).to have_content "Teams: 2"
    expect(game.teams.count).to eq(2)
    expect(Team.last.user).to eq(user2)
    expect(Team.last.game).to eq(game)
    expect(Team.last.draft_order).to eq(game.teams.count)
    expect(page).to have_no_content('Join game')
  end

  scenario 'a non-signed in user cannot join a game' do
    create(:game)

    visit root_path
    click_link 'Join game'

    expect(current_path).to eq sign_in_path
    expect(page).to have_content 'You must sign in'

  end

end
