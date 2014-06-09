class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :rateable, :polymorphic => true #duvida

  scope :positive, -> { where(:positive => true) }
  scope :positives_for, -> (user, type) { where("user_id = ? and rateable_type = ? and positive = true", user.id, type)}
  scope :negative, -> { where(:positive => false) }
  scope :negatives_for, -> (user, type) { where("user_id = ? and rateable_type = ? and positive = false", user.id, type)}
  scope :has_votes_for, -> (user, type) { where("user_id = ? and rateable_type = ?", user.id, type)}

end
