class Notifier::NewStory
  def initialize(story:)
    @story = story
  end

  def notify_all!
    NewActionMailer.new_story(@story, recipients).deliver_now if recipients.present?
  end

  def recipients
    recipients = User.receives_new_story.receives_every_event_report.pluck(:email)
    recipients.delete @story.user.email
    recipients.uniq
  end
end
