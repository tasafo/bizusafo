module ProfilesHelper
  def profile_show_tab_class
    return unless controller_name == "profiles"
    action_name == "show" ? "active" : ""
  end

  def profile_favorite_tab_class
    return unless controller_name == "profiles"
    action_name == "favorites" ? "active" : ""
  end

  def profile_negative_tab_class
    return unless controller_name == "profiles"
    action_name == "negatives" ? "active" : ""
  end

  def profile_comment_tab_class
    return unless controller_name == "profiles"
    action_name == "commented" ? "active" : ""
  end
end
