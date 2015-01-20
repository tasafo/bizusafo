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
    elsif story.user == current_user
      "<span class='popover-trigger' data-toggle='popover' data-placement='top' data-content='#{t("story.cant_rate_on_own_story")}'>#{positive_votes_count(story)}".html_safe
    elsif story.rated_by? current_user
      "<span class='popover-trigger' data-toggle='popover' data-placement='top' data-content='#{t("story.cant_rate_again")}'>#{positive_votes_count(story)}".html_safe
    else
      positive_votes_count(story)
    end
  end

  def story_negative_rating_handler(story)
    if can_rate_for?(story)
      link_to negative_votes_count(story), story_negative_path(story), "data-count" => story.ratings.negative.count
    elsif !current_user
      "<span class='sign-in-to-rate' data-toggle='popover' data-placement='top' data-content='#{sign_in_to_rate_popover_text}'>#{negative_votes_count(story)}".html_safe
    elsif story.user == current_user
      "<span class='popover-trigger' data-toggle='popover' data-placement='top' data-content='#{t("story.cant_rate_on_own_story")}'>#{negative_votes_count(story)}".html_safe
    elsif story.rated_by? current_user
      "<span class='popover-trigger' data-toggle='popover' data-placement='top' data-content='#{t("story.cant_rate_again")}'>#{negative_votes_count(story)}".html_safe
    else
      negative_votes_count(story)
    end
  end

  def sign_in_to_rate_popover_text
    "Para votar, #{link_to "entre aqui", new_user_session_path} ou #{link_to "acesse com o Facebook", user_omniauth_authorize_path(:facebook)}!"
  end

  def can_rate_for?(story)
    return false unless current_user
    rated = story.rated_by? current_user
    story.user != current_user && !rated
  end

  def story_link(story, full_description)
    description = full_description ? story.description : truncate(story.description, length: 300)

    link_to description, story_link_url(story), target: "_blank"
  end

  def story_icon(story)
    if story.url.blank?
      content_tag :span, nil, class:"glyphicon glyphicon-font"
    else
      content_tag :span, nil, class:"glyphicon glyphicon-link"
    end
  end

  def story_link_url(story)
    story.url.blank? ? story_url(story) : story.url
  end

  def story_filter_handler(text, filter_type, filter)
    css_class = "label label-primary" if params[filter_type] && params[filter_type].to_sym == filter

    query = params.merge({ filter_type => filter })
    query.delete :page

    link_to text, current_filtered_url(query), class: css_class
  end

  def current_filtered_url(query)
    url_for :only_path => false, :params => { filter: query[:filter], order: query[:order], tags: query[:tags] }
  end
end
