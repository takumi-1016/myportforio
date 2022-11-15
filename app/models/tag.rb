class Tag < ApplicationRecord
  has_many :tag_relationships, dependent: :destroy, foreign_key: 'tag_id'
  has_many :post_titles, through: :tag_relationships

  validates :name, uniqueness: true, presence: true
end
