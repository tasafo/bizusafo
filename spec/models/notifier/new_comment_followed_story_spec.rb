require "rails_helper"

describe Notifier::NewCommentFollowedStory do
  describe "add_comment!" do

    let(:comment) do
      comment = Comment.new
      Notifier::NewCommentFollowedStory.new(commentable: stories(:how_to), author: users(:amanda), comment: comment).notify_all!
    end

    it "deliveries an email to whoever commented the commentable" do
      comment
      expect(ActionMailer::Base.deliveries.last.bcc).to include users(:victor).email
    end

    it "does not deliver email to the owner of the commentable" do
      comment
      expect(ActionMailer::Base.deliveries.last.bcc).to_not include users(:john).email
    end

    it "does not deliver email to the author of the comment" do
      comment
      expect(ActionMailer::Base.deliveries.last.bcc).to_not include users(:amanda).email
    end

    context "when the commenters do not allow new_comment_followed_story notifications" do
      it "does not deliver any email" do
        users(:victor).notification_setting.update(new_comment_followed_story: false)
        expect do
          comment
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end

    context "when the commenters do not allow every event report notifications" do
      it "does not deliver any email" do
        users(:victor).notification_setting.update(report: NotificationSetting::DAILY_REPORT)
        expect do
          comment
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end
  end
end
