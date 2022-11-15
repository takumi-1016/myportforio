class TagRelationship < ApplicationRecord
  belongs_to :post_title
  belongs_to :tag
  validates :post_title_id, presence: true
  validates :tag_id, presence: true
end
