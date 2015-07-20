require 'faker'

FactoryGirl.define do
  factory :pick do |f|
    association :team
    association :position
    f.name { Faker::Name.name }
    f.from { Faker::Company.name }
    f.round_drafted 1
  end
end
