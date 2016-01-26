class Notifier::DailyReport
  def initialize
  end

  def notify_all!
    ReportMailer.daily_report(recipients: recipients).deliver_now if recipients.present?
  end

  def recipients
    recipients = User.receives_daily_report.pluck(:email)
    recipients.uniq
  end
end
