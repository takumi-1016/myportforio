FactoryBot.define do
  factory :tag_relationship do
    association :post_title
    association :tag
  end
end
