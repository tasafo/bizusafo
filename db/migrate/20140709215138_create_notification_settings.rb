class CreateNotificationSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :notification_settings do |t|
      t.boolean :new_comment_followed_story, default: true
      t.boolean :new_rating, default: true
      t.boolean :new_comment, default: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
