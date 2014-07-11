namespace :add_notification_setting_to_users do
  task :run => :environment do
    User.all.each do |user|
      user.create_notification_setting if user.notification_setting.blank?
    end
  end
end