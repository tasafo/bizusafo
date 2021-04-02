namespace :report do
  desc 'Daily report'
  task daily: :environment do
    Notifier::DailyReport.new.notify_all!
  end

  desc 'Weekly report'
  task weekly: :environment do
    Notifier::WeeklyReport.new.notify_all!
  end
end
