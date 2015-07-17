def create_user(overrides={})
  User.create!({
    name: 'Matt Murdock',
    email: 'daredevil@email.com',
    password: 'manwithoutfear'
  }.merge(overrides))
end

def create_game(overrides={})
  Game.create!({
    name: 'TV Draft',
    description: 'Fantasy draft of TV characters'
  }.merge(overrides))
end

def create_team(game, user, overrides={})
  Team.create!({
    game_id: game.id,
    user_id: user.id,
    name: 'The Mighty Avengers',
    draft_order: 1
  }.merge(overrides))
end

def create_position(game, overrides={})
  Position.create!({
    game_id: game.id,
    name: 'Lead Character in a Drama'
  }.merge(overrides))
end
