namespace :report do
  task :daily_report => :environment do
    Notifier::DailyReport.new.notify_all!
  end

  task :weekly_report => :environment do
    Notifier::WeeklyReport.new.notify_all!
  end
end
