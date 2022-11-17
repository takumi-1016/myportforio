FactoryBot.define do
  factory :user do
    user_name { Faker::Lorem.characters(number: 5) }
    user_profile { Faker::Lorem.characters(number: 20) }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 10) }
    password_confirmation { password }
    association :team
    admin { [true, false].sample }
    certification_id { Faker::Lorem.characters(number: 5) }
  end
end
