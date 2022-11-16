FactoryBot.define do
  factory :like do
    association :user
    association :post_comment
  end
end
