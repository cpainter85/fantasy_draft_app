require 'faker'

FactoryGirl.define do
  factory :team do |f|
    association :game
    association :user
    f.name { Faker::Team.name }
    f.draft_order 1
  end
end
