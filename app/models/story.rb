class Story < ActiveRecord::Base
  acts_as_taggable

  validates :url, format: { with: URI.regexp }, allow_blank: true
  validate :uniqueness_url
  validates :description, presence: true

  scope :timeline, -> { order(created_at: :desc) }
  scope :by_date, -> { order(created_at: :desc) }
  scope :by_rating, -> { order(rating_counter: :desc) }
  scope :by_current_month, -> { where("stories.created_at >= ?", 30.days.ago) }
  scope :by_current_week, -> { where("stories.created_at >= ?", 7.days.ago) }
  scope :by_yesterday, -> { where("stories.created_at >= ?", 1.day.ago) }
  scope :favorited_by, -> (user) do
    eager_load(:ratings).where("ratings.user_id = ? AND ratings.positive = ?", user.id, true)
  end
  scope :negative_by, -> (user) do
    eager_load(:ratings).where("ratings.user_id = ? AND ratings.positive = ?", user.id, false)
  end
  scope :commented_by, -> (user) do
    eager_load(:comments).where("comments.author_id = ?", user.id)
  end

  belongs_to :user
  has_many :ratings, as: :rateable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :comments, reject_if: proc { |attributes| attributes["text"].blank? }

  paginates_per 10

  def self.create_story!(params:, user:)
    story = user.stories.build params
    story.comments.first.author = user if story.comments.present?
    story.save
    notify_new_story!(story) if story.persisted?
    story
  end

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

  private

  def self.notify_new_story!(story)
    Notifier::NewStory.new(story: story).notify_all!
  end

  def uniqueness_url
    return if self.url.blank?
    story = Story.find_by_url self.url
    if story
      link = Rails.application.routes.url_helpers.story_path(story.id)
      link_author = Rails.application.routes.url_helpers.profile_path(story.user)
      errors.add(:url, ": O link já foi compartilhado no Bizusafo pelo <a href='#{link_author}'>#{story.user.username}</a>. Aproveite e comente o <a href='#{link}'>bizu</a>.")
    end
  end
end
