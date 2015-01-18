require 'spec_helper'

describe Story do
  context "Valid data" do
    it { should_not allow_value("is not a url").for :url }
    it { should allow_value("").for :url }
    it { should validate_presence_of(:description) }
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

      xit "notifies when rating is added successfully"
      xit "does not notify when rating is not saved"
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

      xit "notifies when rating is added successfully"
      xit "does not notify when rating is not saved"
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
      stories(:top_tips).update_attribute :created_at, Date.today
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

      filtered_stories.each do |story|
        assert story.created_at > 30.days.ago
      end
    end

    it "by current week" do
      stories = Story.all
      filtered_stories = Story.by_current_week

      assert stories.all.size > filtered_stories.size

      filtered_stories.each do |story|
        assert story.created_at > 7.days.ago
      end
    end
  end
end
