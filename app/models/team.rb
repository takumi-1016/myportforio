class Team < ApplicationRecord
  before_create :default_image

  validates :team_name, length: { minimum: 1, maximum: 20 }, presence: true, uniqueness: true
  validates :certification_id, length: { is: 5 }, presence: true, uniqueness: true

  has_one_attached :team_image
  has_many :users, dependent: :destroy
  has_many :post_titles, dependent: :nullify
  has_many :post_comments, dependent: :nullify

  def default_image
    return if team_image.attached?

    team_image.attach(io: File.open(Rails.root.join('app/assets/images/default-icon.png')),
                      filename: 'default-icon.png', content_type: 'image/png')
  end
end
