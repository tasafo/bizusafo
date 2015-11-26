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
    @commentable.user if @commentable.user.notification_setting.new_comment
  end
end
