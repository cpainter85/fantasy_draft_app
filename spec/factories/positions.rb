require 'faker'

FactoryGirl.define do
  factory :position do |f|
    association :game
    f.name { Faker::Name.title }
  end
end
