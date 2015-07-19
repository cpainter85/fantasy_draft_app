require 'rails_helper'

feature 'User can view picks in a game and draft new picks' do
  let (:user) { create_user }
  let! (:game) { create_game }
  let! (:team) { create_team(game, user) }
  let (:user2) { create_user(email: 'thor@email.com') }
  let! (:team2) { create_team(game, user2, name: 'The Vikings') }
  let! (:position) { create_position(game) }
  let! (:position2) { create_position(game, name: 'Catchphrase') }
  let! (:pick1) { create_pick(team, position) }
  let! (:pick2) { create_pick(team2, position2) }

  scenario 'anyone can view game progress' do
    visit root_path
    click_link game.name

    expect(current_path).to eq game_path(game)
    page_content = ['Round 1',
                    'Round 2',
                    game.name,
                    team.name,
                    team2.name,
                    pick1.name,
                    pick1.from,
                    pick1.position.name,
                    pick2.name,
                    pick2.from,
                    pick2.position.name]

    page_content.each do |content|
      expect(page).to have_content content
    end
  end
end
