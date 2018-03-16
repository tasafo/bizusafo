class AddStoryNotificationsToNotificationSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :notification_settings, :new_stories, :boolean, default: true
    add_column :notification_settings, :report, :string, default: "every_event"
  end
end
