require "rails_helper"

describe Notifier::NewComment do
  describe "add_comment!" do

    let(:comment) do
      comment = Comment.new
      Notifier::NewComment.new(commentable: stories(:how_to), author: users(:amanda), comment: comment).notify_all!
    end

    it "delivers an email to the owner of the commentable" do
      comment
      expect(ActionMailer::Base.deliveries.last.to).to include users(:john).email
    end

    context "when the owner of the commentable does not allow new_comment notifications" do
      it "does not deliver any email" do
        users(:john).notification_setting.update_attributes(new_comment: false)
        expect do
          comment
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end

    context "when the owner of the commentable do not allow every event report notifications" do
      it "does not deliver any email" do
        users(:john).notification_setting.update_attributes(report: NotificationSetting::DAILY_REPORT)
        expect do
          comment
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end
  end
end
