namespace :add_notification_settings_to_users do
  task :run => :environment do
    User.all.each do |user|
      user.create_notification_settings if user.notification_settings.blank?
    end
  end
end