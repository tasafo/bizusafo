class Notifier::NewRating
  def initialize(args)
    @rater = args[:rater]
    @story = args[:story]
  end

  def notify_all!
    NewActionMailer.new_rating(@rater, @story, recipients).deliver if recipients.present?
  end

  def recipients
    @story.user if @story.user.notification_setting.new_rating
  end
end