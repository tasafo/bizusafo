class Notifier::NewComment
  def initialize(args)
    @author = args[:author]
    @commentable = args[:commentable]
    @comment = args[:comment]
  end

  def notify_all!
    NewActionMailer.new_comment(@author, @commentable, @comment, recipients).deliver_now if recipients.present?
  end

  def recipients
    settings = @commentable.user.notification_setting
    @commentable.user if settings.new_comment? && settings.every_event_report?
  end
end
