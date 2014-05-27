class Story < ActiveRecord::Base
  validates :url, format: { with: URI.regexp }
  validates :description, :url, presence: true

  scope :timeline, -> { order(created_at: :desc) }

  belongs_to :user
  has_many :ratings, as: :rateable
end
