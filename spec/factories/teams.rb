FactoryBot.define do
  factory :team do
    team_name { Faker::Lorem.characters(number: 5) }
    certification_id { Faker::Lorem.characters(number: 5) }
  end
end
