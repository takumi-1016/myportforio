FactoryBot.define do
  factory :post_title do
    association :user
    association :team
    sequence(:title) { |n| "title-#{n}" }

    after(:create) do |title|
      create_list(:tag_relationship, 1, post_title: title, tag: create(:tag))
    end
  end
end
