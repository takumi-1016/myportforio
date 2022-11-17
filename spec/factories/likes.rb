FactoryBot.define do
  factory :like do
    association :post_comment
    user { post_comment.user }
  end
end
