class Comment < ActiveRecord::Base
  validates :text, presence: true

  belongs_to :author, class_name: "User"
  belongs_to :commentable, :polymorphic => true

  delegate :username, to: :author, allow_nil: true
end
