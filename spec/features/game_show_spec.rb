require 'rails_helper'

feature 'User can view picks in a game and draft new picks' do
  scenario 'anyone can view game progress' do
    game = create(:game)
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
end
