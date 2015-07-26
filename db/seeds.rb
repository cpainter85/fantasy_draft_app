# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

Game.destroy_all
User.destroy_all
Team.destroy_all
Position.destroy_all
Pick.destroy_all

game = Game.create(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph)
user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password1234')
team = Team.create(game: game, user: user, name: Faker::Team.name, draft_order: 1)
other_teams = (1..5).each { |number| Team.create(game: game, user: user, name: Faker::Team.name, draft_order: number+1) }
positions = (1..15).map { Position.create(game: game, name: Faker::Name.title) }
round_1_picks = game.teams.each_with_index {|team, index| Pick.create(team: team, position: positions[index], name: Faker::Name.name, from: Faker::Company.name, round_drafted: 1)}
round_2_picks = game.teams.each_with_index {|team, index| Pick.create(team: team, position: positions[index+1], name: Faker::Name.name, from: Faker::Company.name, round_drafted: 2)}

game2 = Game.create(name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph)
game2_users = (1..8).map { User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password(8)) }
game2_teams = (1..8).each_with_index { |num, index| Team.create(game: game2, user: game2_users[index], name: Faker::Team.name, draft_order: num)}
game2_positions = (1..25).map { Position.create(game: game2, name: Faker::Name.title) }
