class Notifier::NewRating
  def initialize(args)
    @rater = args[:rater]
    @story = args[:story]
  end

  def notify_all!
    NewActionMailer.new_rating(@rater, @story, recipients).deliver_now if recipients.present?
  end

  def recipients
    settings = @story.user.notification_setting
    @story.user if settings.new_rating? && settings.every_event_report?
  end
end
