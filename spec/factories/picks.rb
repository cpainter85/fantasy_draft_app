require 'faker'

FactoryGirl.define do
  factory :pick do |f|
    association :team
    association :position
    f.name { Faker::Name.name }
    f.from { Faker::Company.name }
    f.round_drafted { Faker::Number.between(1, 1000) }
  end
end
