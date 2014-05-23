module StoriesHelper
  def positive_votes_count(story)
    count = story.ratings.positive.count

    return "manter" if count.zero?

    return "+ #{count}"
  end

  def negative_votes_count(story)
    count = story.ratings.negative.count

    return "retirar" if count.zero?

    return "- #{count}"
  end

  def positive_ratings_url(story)
    return "#" unless current_user

    votes = Rating.has_votes_for current_user, "Story"

    return story_positive_path(story) if story.user != current_user and votes.empty?

    "#"
  end

  def negative_ratings_url(story)
    return "#" unless current_user
    
    votes = Rating.has_votes_for current_user, "Story"

    return story_negative_path(story) if story.user != current_user and votes.empty?

    "#"
  end
end
