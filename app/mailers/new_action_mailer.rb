class NewActionMailer < ApplicationMailer
  def new_story(story, recipients)
    @story = story
    @recipients = recipients

    mail(to: "Bizu <nao-responda@#{ENV['HOST_URL']}>", bcc: @recipients, subject: I18n.t("notifications.new_story.subject"))
  end

  def new_rating(rater, story, recipient)
    @rater = rater
    @story = story
    @recipient = recipient

    mail(to: @recipient.email, subject: I18n.t("notifications.new_rating.subject"))
  end

  def new_comment(author, commentable, comment, recipient)
    @author = author
    @commentable = commentable
    @comment = comment
    @recipient = recipient

    mail(to: @recipient.email, subject: I18n.t("notifications.new_comment.subject"))
  end

  def new_comment_followed_story(author, commentable, comment, recipients)
    @author = author
    @commentable = commentable
    @comment = comment
    @recipients = recipients

    mail(to: "Bizu <nao-responda@#{ENV['HOST_URL']}>", bcc: @recipients, subject: I18n.t("notifications.new_comment_followed_story.subject"))
  end
end
