require "spec_helper"

describe User do
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
        assert User.commented_on_story(story).include?(commenter)
      end

      it "does not return users who commented on some story" do
        assert !User.commented_on_story(story).include?(regular_user)
      end
    end

    describe "receives_new_comment_followed_story" do
      it "returns users who accepts new_comment_followed_story notifications" do
        assert User.receives_new_comment_followed_story.include?(commenter)
      end

      it "does not return users who accepts new_comment_followed_story notifications" do
        assert !User.receives_new_comment_followed_story.include?(regular_user)
      end
    end
  end
end
