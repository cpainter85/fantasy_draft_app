def create_user(overrides={})
  User.create!({
    name: 'Matt Murdock',
    email: 'daredevil@email.com',
    password: 'manwithoutfear'
  }.merge(overrides))
end
