require 'rails_helper'

describe Story, :type => :model do
  context "Valid data" do
    it { should_not allow_value("is not a url").for :url }
    it { should allow_value("").for :url }
    it { should validate_presence_of(:description) }
  end

  describe "create_story!" do
    fixtures(:users)
    fixtures(:stories)
    fixtures(:comments)
    fixtures(:notification_settings)

    let(:valid_story_params) {
      {
        description: "Description",
        url: "http://google.com",
        tag_list: "tag1, tag2",
        comments_attributes: { "0" => { text: "Some comment" } }
      }
    }

    let!(:story) { Story.create_story! params: valid_story_params, user: users(:amanda) }

    it "creates a story with the given params" do
      expect(story).to be_valid
    end

    it "returns a new story" do
      assert story.kind_of? Story
    end

    it "creates a story with first comment" do
      expect(story.comments.count).to eql 1

      expect(users(:amanda).reload.comments.last.text).to eql "Some comment"
    end

    context "when story is created successfully" do
      it "deliveries an email to every one listes to receive notifications" do
        story

        expect(ActionMailer::Base.deliveries.last.bcc.size).to eql 2
        expect(ActionMailer::Base.deliveries.last.bcc).to include users(:john).email
        expect(ActionMailer::Base.deliveries.last.bcc).to include users(:victor).email
      end
    end

    context "when story is not created successfully" do
      it "uniqueness url" do
        valid_story_params[:url] = story.url
        valid_story_params[:user] = User.first
        new_story = Story.new(valid_story_params)

        expect(new_story.save).to be false
        expect(new_story.errors[:url].present?).to be true
      end
    end


    context "when the comment is not created successfully" do
      it "does not deliver any email" do
        expect do
          Story.create_story!(params: {}, user: User.first)
        end.to change{ActionMailer::Base.deliveries.size}.by(0)
      end
    end
  end

  context "ratings" do
    describe "add_positive_rating" do
      fixtures :users
      fixtures :stories

      let!(:user) { users(:john) }
      let!(:story) { stories(:how_to) }

      it "adds positive rating to story" do
        story.add_positive_rating! user

        assert story.ratings.last.positive
      end

      it "increments story rating_counter" do
        ratings_expected = story.rating_counter + 1

        story.add_positive_rating! user

        assert_equal story.rating_counter, ratings_expected
      end
    end

    describe "add_negative_rating" do
      fixtures :users
      fixtures :stories

      let!(:user) { users(:john) }
      let!(:story) { stories(:how_to) }

      it "adds negative rating to story" do
        story.add_negative_rating! user

        assert !story.ratings.last.positive
      end

      it "decrements story rating_counter" do
        ratings_expected = story.rating_counter - 1

        story.add_negative_rating! user

        assert_equal story.rating_counter, ratings_expected
      end
    end
  end

  describe "rated_by?" do
    fixtures :users
    fixtures :stories
    fixtures :ratings

    let!(:user) { users(:john) }

    it "returns true if user rated story" do
      story = stories(:how_to)
      assert story.rated_by?(user)
    end

    it "returns false if user did not rate story" do
      story = stories(:top_tips)
      assert !story.rated_by?(user)
    end
  end

  describe "scope favorited_by user" do
    fixtures :stories
    fixtures :ratings
    fixtures :users

    it "returns stories rated posivite by user" do
      expect(Story.favorited_by(users :john)).to include stories(:how_to)
    end

    it "does not return stories rated negative by user" do
      expect(Story.favorited_by(users :john)).to_not include stories(:best_coders)
    end

    it "does not return stories not rated by user" do
      expect(Story.favorited_by(users :john)).to_not include stories(:top_tips)
    end
  end

  describe "scope negative_by user" do
    fixtures :stories
    fixtures :ratings
    fixtures :users

    it "returns stories rated negative by user" do
      expect(Story.negative_by(users :john)).to include stories(:best_coders)
    end

    it "does not return stories rated positive by user" do
      expect(Story.negative_by(users :john)).to_not include stories(:how_to)
    end

    it "does not return stories not rated by user" do
      expect(Story.negative_by(users :john)).to_not include stories(:top_tips)
    end
  end

  describe "scope commented_by user" do
    fixtures :comments
    fixtures :stories
    fixtures :users

    it "returns stories commented by user" do
      expect(Story.commented_by(users :john)).to include stories(:how_to)
    end

    it "does not return stories not commented by user" do
      expect(Story.commented_by(users :john)).to_not include stories(:best_coders)
    end
  end

  describe "filters orders stories" do
    fixtures :stories

    before do
      stories(:how_to).update_attribute :created_at, 25.days.ago
      stories(:top_tips).update_attribute :created_at, 1.day.ago + 1.minute
      stories(:best_coders).update_attribute :created_at, 3.months.ago
    end

    it "by DESC date" do
      stories = Story.by_date
      sorted_stories = stories.sort_by { |story| story.created_at }.reverse
      expect(stories).to be == sorted_stories
    end

    it "by rating" do
      stories = Story.by_rating
      sorted_stories = stories.sort_by { |story| story.rating_counter }.reverse
      expect(stories).to be == sorted_stories
    end

    it "by current month" do
      stories = Story.all
      filtered_stories = Story.by_current_month

      assert stories.all.size > filtered_stories.size

      expect(filtered_stories.size).to eql 2

      filtered_stories.each do |story|
        assert story.created_at > 30.days.ago
      end
    end

    it "by current week" do
      stories = Story.all
      filtered_stories = Story.by_current_week

      assert stories.all.size > filtered_stories.size

      expect(filtered_stories.size).to eql 1

      filtered_stories.each do |story|
        assert story.created_at > 7.days.ago
      end
    end

    it "by yesterday" do
      stories = Story.all
      filtered_stories = Story.by_yesterday

      assert stories.all.size > filtered_stories.size

      expect(filtered_stories.size).to eql 1

      filtered_stories.each do |story|
        assert story.created_at > 1.day.ago
      end
    end
  end
end
