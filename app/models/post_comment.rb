class PostComment < ApplicationRecord
  validates :comment, presence: true

  belongs_to :user
  belongs_to :team
  belongs_to :post_title
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
