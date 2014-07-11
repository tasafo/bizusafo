class Comment < ActiveRecord::Base
  validates :text, presence: true

  belongs_to :author, class_name: "User"
  belongs_to :commentable, :polymorphic => true

  delegate :username, to: :author, allow_nil: true

  def self.add_comment!(params)
    comment = create(params)
    notify_comment!(comment) if comment.persisted?
    comment
  end

  private

  def self.notify_comment!(comment)
    Notifier::NewComment.new(commentable: comment.commentable, author: comment.author, comment: comment).notify_all!
    Notifier::NewCommentFollowedStory.new(commentable: comment.commentable, author: comment.author, comment: comment).notify_all!
  end
end