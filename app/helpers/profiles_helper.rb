module ProfilesHelper
  def profile_show_tab_class
    return unless controller_name == "profiles"

    "active" if action_name == "show"
  end

  def profile_favorite_tab_class
    return unless controller_name == "profiles"

    "active" if action_name == "favorites"
  end

  def profile_negative_tab_class
    return unless controller_name == "profiles"

    "active" if action_name == "negatives"
  end

  def profile_comment_tab_class
    return unless controller_name == "profiles"

    "active" if action_name == "commented"
  end
end
