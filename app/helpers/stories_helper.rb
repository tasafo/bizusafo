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

  def disabled_field(story)
    story.new_record? ? nil : "disabled"
  end

  def story_positive_rating_handler(story)
    if can_rate_for?(story)
      link_to positive_votes_count(story), story_positive_path(story), "data-count" => story.ratings.positive.count
    elsif !current_user
      "<span class='sign-in-to-rate' data-toggle='popover' data-placement='top' data-content='#{sign_in_to_rate_popover_text}'>#{positive_votes_count(story)}".html_safe
    else
      positive_votes_count(story)
    end
  end

  def story_negative_rating_handler(story)
    if can_rate_for?(story)
      link_to negative_votes_count(story), story_negative_path(story), "data-count" => story.ratings.negative.count
    elsif !current_user
      "<span class='sign-in-to-rate' data-toggle='popover' data-placement='top' data-content='#{sign_in_to_rate_popover_text}'>#{negative_votes_count(story)}".html_safe
    else
      negative_votes_count(story)
    end
  end

  def sign_in_to_rate_popover_text
    "Para votar, #{link_to "entre aqui", new_user_session_path} ou #{link_to "acesse com o Facebook", user_omniauth_authorize_path(:facebook)}!"
  end

  def can_rate_for?(story)
    return false unless current_user
    rates = story.ratings.has_votes_for current_user, "Story"
    story.user != current_user && rates.empty?
  end

  def story_order_handler(text, order, args = {})
    klass = "label label-primary" if params["order"] && params["order"].to_sym == order
    link_to text, root_path({ order: order }.merge args), class: klass
  end

  def story_filter_handler(text, filter, args = {})
    klass = "label label-primary" if params["filter"] && params["filter"].to_sym == filter
    link_to text, root_path({ filter: filter }.merge args), class: klass
  end
end
