class Notifier::NewCommentFollowedStory
  def initialize(args)
    @author = args[:author]
    @commentable = args[:commentable]
    @comment = args[:comment]
  end

  def notify_all!
    NewActionMailer.new_comment_followed_story(@author, @commentable, @comment, recipients).deliver if recipients.present?
  end

  def recipients
    recipients = User.commented_on_story(@commentable).receives_new_comment_followed_story.pluck(:email)
    recipients.delete @commentable.user.email
    recipients.delete @author.email
    recipients.uniq
  end
end
