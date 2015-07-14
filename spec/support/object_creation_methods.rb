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
