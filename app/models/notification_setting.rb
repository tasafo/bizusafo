class NotificationSetting < ActiveRecord::Base
  belongs_to :user

  NO_REPORT = "no_report"
  EVERY_EVENT_REPORT = "every_event"
  DAILY_REPORT = "daily_report"
  WEEKLY_REPORT = "weekly_report"

  validates_inclusion_of :report, in: [NO_REPORT, EVERY_EVENT_REPORT, DAILY_REPORT, WEEKLY_REPORT]

  def no_report?
    self.report == NO_REPORT
  end

  def every_event_report?
    self.report == EVERY_EVENT_REPORT
  end

  def daily_report_report?
    self.report == DAILY_REPORT
  end

  def weekly_report_report?
    self.report == WEEKLY_REPORT
  end
end
