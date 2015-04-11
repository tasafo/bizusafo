require "rails_helper"

describe Notifier::NewRating do
  describe "add_comment!" do
    fixtures(:users)
    fixtures(:stories)
    fixtures(:comments)
    fixtures(:notification_settings)

    let(:rate) do
      Notifier::NewRating.new(story: stories(:how_to), rater: users(:amanda)).notify_all!
    end

    it "delivers an email to the owner of the commentable" do
      rate
      expect(ActionMailer::Base.deliveries.last.to).to include users(:john).email
    end

    context "when the owner of the commentable does not allows new_comment notifications" do
      it "does not deliver any email" do
        users(:john).notification_setting.update_attributes(new_rating: false)
        expect do
          rate
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end
  end
end
