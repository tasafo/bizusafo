module ApplicationHelper
  def avatar_url(user)
    return user.facebook_image if user.facebook_image.present?

    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
