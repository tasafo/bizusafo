require "rails_helper"

describe NotificationSetting do

  context "Valid data" do
    it { should validate_inclusion_of(:report).in_array [
      NotificationSetting::NO_REPORT,
      NotificationSetting::EVERY_EVENT_REPORT,
      NotificationSetting::DAILY_REPORT,
      NotificationSetting::WEEKLY_REPORT
    ] }
  end

  context "report status" do
    let(:setting) { NotificationSetting.new report: report }

    context "when report is NO_REPORT" do
      let(:report) { NotificationSetting::NO_REPORT }
      subject { setting.no_report? }

      it { should be true }
    end

    context "when report is EVERY_EVENT" do
      let(:report) { NotificationSetting::EVERY_EVENT_REPORT }
      subject { setting.every_event_report? }

      it { should be true }
    end

    context "when report is DAILY_REPORT" do
      let(:report) { NotificationSetting::DAILY_REPORT }
      subject { setting.daily_report_report? }

      it { should be true }
    end

    context "when report is WEEKLY_REPORT" do
      let(:report) { NotificationSetting::WEEKLY_REPORT }
      subject { setting.weekly_report_report? }

      it { should be true }
    end
  end
end
