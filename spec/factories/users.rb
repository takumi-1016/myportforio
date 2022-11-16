FactoryBot.define do
  factory :user do
    user_name { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 10) }
    association :team
  end
end
