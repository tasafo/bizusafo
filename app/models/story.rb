class Story < ActiveRecord::Base
  acts_as_taggable

  validates :url, format: { with: URI.regexp }, allow_blank: true
  validates :description, presence: true

  scope :timeline, -> { order(created_at: :desc) }
  scope :by_date, -> { order(created_at: :desc) }
  scope :by_rating, -> { order(rating_counter: :desc) }
  scope :by_current_month, -> { where("stories.created_at > ?", 30.days.ago) }
  scope :by_current_week, -> { where("stories.created_at > ?", 7.days.ago) }
  scope :favorited_by, -> (user) { includes(:ratings).where("ratings.user_id" => user.id, "ratings.positive" => true) }
  scope :negative_by, -> (user) { includes(:ratings).where("ratings.user_id" => user.id, "ratings.positive" => false) }
  scope :commented_by, -> (user) { includes(:comments).where("comments.author_id" => user.id) }

  belongs_to :user
  has_many :ratings, as: :rateable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :comments, reject_if: proc { |attributes| attributes["text"].blank? }

  paginates_per 10

  def rated_by?(user)
    ratings.has_votes_for(user, "Story").any?
  end

  def add_positive_rating!(user)
    add_rating! user, true
  end

  def add_negative_rating!(user)
    add_rating! user, false
  end

  def add_rating!(user, positive)
    notify = false
    transaction do
      self.ratings.create(:user => user, :positive => positive)
      self.rating_counter = self.rating_counter + 1 if positive
      self.rating_counter = self.rating_counter - 1 if not positive

      notify = save
    end
    Notifier::NewRating.new(rater: user, story: self).notify_all! if notify
  end
end
