class User < ApplicationRecord
  before_create :default_image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, length: { minimum: 1, maximum: 15 }, presence: true

  has_one_attached :user_image
  belongs_to :team, optional: true
  has_many :post_titles, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@test.com', user_name: 'guest') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def default_image
    return if user_image.attached?

    user_image.attach(io: File.open(Rails.root.join('app/assets/images/default-icon.png')),
                      filename: 'default-icon.png', content_type: 'image/png')
  end
end
