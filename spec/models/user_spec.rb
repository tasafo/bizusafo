require 'rails_helper'

describe User, :type => :model do
  let(:user) { User.new }

  context "Erros de validação em português" do
    it { should_not be_valid }
  end

  context "scopes" do
    fixtures :users
    fixtures :stories
    fixtures :comments
    fixtures :notification_settings

    let(:story) { stories(:how_to) }
    let(:comment) { comments(:john_how_to) }
    let(:commenter) { users(:john) }
    let(:regular_user) { users(:amanda) }

    describe "commented_on_story" do
      it "returns users who commented on some story" do
        expect(User.commented_on_story(story)).to include commenter
      end

      it "does not return users who did not comment on some story" do
        assert !User.commented_on_story(story).include?(regular_user)
      end
    end

    describe "receives_new_comment_followed_story" do
      it "returns users who accepts new_comment_followed_story notifications" do
        assert User.receives_new_comment_followed_story.include?(commenter)
      end

      it "does not return users who does not accept new_comment_followed_story notifications" do
        assert !User.receives_new_comment_followed_story.include?(regular_user)
      end
    end

    describe "receives_new_story" do
      it "returns users who accepts new_stories notifications" do
        regular_user.notification_setting.update new_stories: true
        assert User.receives_new_story.include?(regular_user)
      end

      it "does not return users who dos not accept new_stories notifications" do
        regular_user.notification_setting.update new_stories: false
        assert !User.receives_new_story.include?(regular_user)
      end
    end

    describe "receives_every_event_report" do
      it "returns users who accepts every_event_report notifications" do
        regular_user.notification_setting.update report: "every_event"
        assert User.receives_every_event_report.include?(regular_user)
      end

      it "does not return users who does not accept every_event_report notifications" do
        regular_user.notification_setting.update report: "daily_report"
        assert !User.receives_every_event_report.include?(regular_user)
      end
    end

    describe "receives_daily_report" do
      it "returns users who accepts daily reports notifications" do
        regular_user.notification_setting.update report: "daily_report"
        assert User.receives_daily_report.include?(regular_user)
      end

      it "does not return users who does not accept daily reports notifications" do
        regular_user.notification_setting.update report: "weekly_report"
        assert !User.receives_daily_report.include?(regular_user)
      end
    end

    describe "receives_weekly_report" do
      it "returns users who accepts weekly reports notifications" do
        regular_user.notification_setting.update report: "weekly_report"
        assert User.receives_weekly_report.include?(regular_user)
      end

      it "does not return users who does not accept weekly reports notifications" do
        regular_user.notification_setting.update report: "daily_report"
        assert !User.receives_weekly_report.include?(regular_user)
      end
    end
  end
end
