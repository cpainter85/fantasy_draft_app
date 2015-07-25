require 'rails_helper'

feature 'User can view picks in a game and draft new picks' do
  let (:game) { create(:game) }

  scenario 'anyone can view game progress' do
    teams = create_list(:team, 5, game: game)
    positions = create_list(:position, 10, game: game)
    round_1_picks = teams.map.with_index { |team, index| create(:pick, team: team, position: positions[index], round_drafted: 1) }
    round_2_picks = teams.map.with_index { |team, index| create(:pick, team: team, position: positions[index+5], round_drafted: 2) }

    visit root_path
    click_link game.name

    expect(current_path).to eq game_path(game)
    expect(page).to have_content game.name
    (1..positions.length).each { |round| expect(page).to have_content "Round #{round}" }
    teams.each { |team| expect(page).to have_content team.name }

    round_1_picks.concat(round_2_picks).each do |pick|
      expect(page).to have_content pick.name
      expect(page).to have_content pick.from
      expect(page).to have_content pick.position.name
    end
  end

  scenario 'a user with a team can make a draft pick' do
    users = create_list(:user, 5)
    user_sign_in(users.first)
    teams = users.map { |user| create(:team, user: user, game: game) }
    create_list(:position, 10, game: game)
    team = users.first.participating_team(game)
    new_pick = { name: Faker::Name.name, from: Faker::Company.name, position: game.positions.last.name }

    visit game_path(game)
    click_link "Make Draft Pick"

    expect(current_path).to eq new_game_team_pick_path(game, team)
    expect(page).to have_content "Draft Character (Round #{team.picks.count+1})"

    fill_in 'Name', with: new_pick[:name]
    fill_in 'From', with: new_pick[:from]
    select(new_pick[:position], from: 'Position')
    click_button 'Draft'

    expect(page).to have_content "#{team.name} successfully drafted #{new_pick[:name]}!"
    new_pick.each_value { |value| expect(page).to have_content value }
    expect(Pick.last.round_drafted).to eq(team.picks.count)
  end

  scenario 'a non-participant cannot see the draft pick link' do
    create_list(:team, 5, game: game)
    create_list(:position, 10, game: game)

    visit game_path(game)
    expect(page).to have_no_content 'Make Draft Pick'
  end

  scenario 'a team must belong to the game to see new draft pick page, otherwise 404' do
    create_list(:team, 5, game: game)
    create_list(:position, 10, game: game)

    user = create(:user)
    user_sign_in(user)
    team = create(:team, user: user)

    visit new_game_team_pick_path(game, team)
    expect(page.status_code).to eq(404)
  end

  scenario 'trying to access the new draft pick screen without being to correct team owner results in a 404 error' do
    game = create(:game)
    create_list(:team, 5, game: game)
    create_list(:position, 10, game: game)

    visit new_game_team_pick_path(game, Team.last)

    expect(page.status_code).to eq(404)
  end
end
