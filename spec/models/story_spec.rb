require 'spec_helper'

describe Story do
  context "Dados válidos" do
    it { should_not allow_value("nao é uma url").for :url }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:url) }
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
