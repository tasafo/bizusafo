require "rails_helper"

describe Comment do
  describe "add_comment!" do
    fixtures(:users)
    fixtures(:stories)
    fixtures(:comments)
    fixtures(:notification_settings)

    let(:comment) { Comment.add_comment! commentable_id: stories(:how_to).id, commentable_type: "Story", text: "text", author_id: users(:amanda).id  }

    it "creates a comment with the given params" do
      expect do
        comment
      end.to change{Comment.count}.by(1)
    end

    it "returns a new comment" do
      assert comment.kind_of? Comment
    end

    context "when comment is created successfully" do
      it "deliveries an email to the owner of the commentable" do
        comment
        expect(ActionMailer::Base.deliveries.last(2).first.to).to include users(:john).email
      end

      it "deliveries an email to whoever commented the commentable" do
        comment
        expect(ActionMailer::Base.deliveries.last.bcc).to include users(:victor).email
      end
    end


    context "when the comment is not created successfully" do
      it "does not deliver any email" do
        expect do
          Comment.add_comment!({})
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end
  end
end
