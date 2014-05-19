class Story < ActiveRecord::Base
  validates :url, format: { with: URI.regexp }
  validates :description, :url, presence: true

  scope :timeline, -> { order(created_at: :desc) }

  belongs_to :user

  def created_date
    created_at.strftime("%d/%m/%Y - %H:%M")
  end
end
