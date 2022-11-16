FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number: 20) }
    association :user
    association :team
    association :post_title
  end
end
