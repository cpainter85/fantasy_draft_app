require 'rails_helper'

feature 'User can view team roster' do
  let (:game) { create(:game) }

  scenario 'clicking on team name from game show page shows that team\'s roster' do
    team = create(:team, game: game)
    other_teams = create_list(:team, 5, game: game)
    positions = create_list(:position, 15, game: game)
    round_1_picks = game.teams.map.with_index { |team, index| create(:pick, team: team, position: positions[index], round_drafted: 1) }
    round_2_picks = game.teams.map.with_index { |team, index| create(:pick, team: team, position: positions[index+5], round_drafted: 2) }

    visit game_path(game)

    first(:link, team.name).click

    expect(current_path).to eq game_team_path(game, team)
    expect(page).to have_content team.name
    ['Position', 'Name', 'From', 'Round Drafted'].each { |elem| expect(page).to have_content elem }
    positions.each { |position| expect(page).to have_content position.name }
    team.picks.each do |pick|
      expect(page).to have_content pick.name
      expect(page).to have_content pick.from
      expect(page).to have_content pick.round_drafted
    end
  end

end
