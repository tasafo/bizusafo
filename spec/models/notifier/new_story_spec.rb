require "rails_helper"

describe Notifier::NewStory do
  describe "new_story!" do

    let(:valid_params) do
      { url: "http://google.com",
        description: "Search on google",
        user: users(:amanda)  }
    end

    let(:story) do
      story = Story.create valid_params
      Notifier::NewStory.new(story: story).notify_all!
    end

    it "deliveries an email to whoever receives new_stories" do
      story
      expect(ActionMailer::Base.deliveries.last.bcc).to include users(:victor).email
      expect(ActionMailer::Base.deliveries.last.bcc).to include users(:john).email
    end

    it "does not deliver email to the owner of the story" do
      story
      expect(ActionMailer::Base.deliveries.last.bcc).to_not include users(:amanda).email
    end

    context "when the commenters do not allow new_stories notifications" do
      it "does not deliver any email" do
        NotificationSetting.update_all new_stories: false

        expect do
          story
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end

    context "when the commenters do not allow every event report notifications" do
      it "does not deliver any email" do
        NotificationSetting.update_all report: NotificationSetting::DAILY_REPORT

        expect do
          story
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end
  end
end
