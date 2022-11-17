class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post_comment

  validates :user_id, presence: true
  validates :post_comment_id, uniqueness: { scope: :user_id }, presence: true
end
