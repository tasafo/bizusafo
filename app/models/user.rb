class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  validates :username, :email, presence: true

  has_many :stories
  has_many :ratings
  has_many :comments, :foreign_key => 'author_id'

  has_one :notification_setting, :dependent => :destroy
  before_create :build_notification_setting

  scope :commented_on_story, -> (story) { joins(:comments).where("comments.commentable_id = ? AND comments.commentable_type = 'Story'", story.id) }
  scope :receives_new_comment_followed_story, -> { joins(:notification_setting).where("notification_settings.new_comment_followed_story = ?", true) }
  scope :receives_new_story, -> { joins(:notification_setting).where("notification_settings.new_stories = ?", true) }
  scope :receives_every_event_report, -> { joins(:notification_setting).where("notification_settings.report = ?", NotificationSetting::EVERY_EVENT_REPORT) }
  scope :receives_daily_report, -> { joins(:notification_setting).where("notification_settings.report = ?", NotificationSetting::DAILY_REPORT) }
  scope :receives_weekly_report, -> { joins(:notification_setting).where("notification_settings.report = ?", NotificationSetting::WEEKLY_REPORT) }

  def self.find_or_create_for_facebook_oauth(auth)
    user = where(auth.info.slice(:email).to_h).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.username = "#{auth.info.first_name} #{auth.info.last_name}".strip
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.facebook_image = auth.info.image
    end

    update_facebook_user_info(user, auth) if user.uid.nil?
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def self.update_facebook_user_info(user, auth)
    user.update_attributes(
      facebook_image: auth.info.image,
      provider: auth.provider,
      uid: auth.uid,
      name: auth.info.name)
  end
end
