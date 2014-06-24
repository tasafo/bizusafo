class Story < ActiveRecord::Base
  validates :url, format: { with: URI.regexp }
  validates :description, :url, presence: true

  scope :timeline, -> { order(created_at: :desc) }
  scope :by_date, -> { order(created_at: :desc) }
  scope :by_rating, -> { order(rating_counter: :desc) }
  scope :by_current_month, -> { where("created_at > ?", 30.days.ago) }
  scope :by_current_week, -> { where("created_at > ?", 7.days.ago) }

  belongs_to :user
  has_many :ratings, as: :rateable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :comments, reject_if: proc { |attributes| attributes["text"].blank? }

  paginates_per 10

  def rated_by?(rater)
    ratings.includes(:user).map(&:user).include? rater
  end

  def add_positive_rating!(user)
    transaction do
      self.ratings.create(:user => user, :positive => true)
      self.rating_counter = self.rating_counter + 1
      save
    end
  end


  def add_negative_rating!(user)
    transaction do
      self.ratings.create(:user => user, :positive => false)
      self.rating_counter = self.rating_counter - 1
      save
    end
  end
end
