require "rails_helper"

describe Notifier::WeeklyReport do
  describe "notify_all!" do
    fixtures(:stories)
    fixtures(:users)
    fixtures(:notification_settings)

    let(:notify) do
      Notifier::WeeklyReport.new.notify_all! force: true
    end

    before do
      allow(Date).to receive(:current).and_return(Date.current.end_of_week)
      NotificationSetting.update_all report: NotificationSetting::DAILY_REPORT
      users(:victor).notification_setting.update report: NotificationSetting::WEEKLY_REPORT
    end

    it "deliveries an email to whoever receives daily_report" do
      notify
      expect(ActionMailer::Base.deliveries.last.bcc).to eql [users(:victor).email]
    end

    it "does not deliver email to does not received daily_report" do
      notify
      expect(ActionMailer::Base.deliveries.last.bcc).to_not include users(:amanda).email
    end

    context "when the commenters do not allow daily_report notifications" do
      it "does not deliver any email" do
        NotificationSetting.update_all report: NotificationSetting::DAILY_REPORT

        expect do
          notify
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end
  end
end
