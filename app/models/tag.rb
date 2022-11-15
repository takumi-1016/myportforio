class Tag < ApplicationRecord
  has_many :tag_relationships, dependent: :destroy
  has_many :post_titles, through: :tag_relationships

  validates :name, presence: true
end
