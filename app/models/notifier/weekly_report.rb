class Notifier::WeeklyReport
  def initialize
  end

  def notify_all!(force: false)
    return if !force || Date.current == Date.current.beginning_of_week

    ReportMailer.weekly_report(recipients: recipients).deliver_now if recipients.present?
  end

  def recipients
    recipients = User.receives_weekly_report.pluck(:email)
    recipients.uniq
  end
end
