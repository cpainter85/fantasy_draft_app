require 'faker'

FactoryGirl.define do
  factory :game do |f|
    f.name { Faker::Lorem.sentence }
    f.description { Faker::Lorem.paragraph }
  end
end
