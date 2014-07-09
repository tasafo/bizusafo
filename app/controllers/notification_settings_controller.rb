class NotificationSettingsController < ApplicationController
  def update
    @settings = current_user.notification_settings
    
    if @settings.update_attributes(notification_params)
      redirect_to edit_user_registration_path, notice: I18n.t("notification_settings.update") 
    else
      redirect_to edit_user_registration_path, alert: I18n.t("notification_settings.error")
    end
  end

  protected

  def notification_params
    params.require(:notification_settings).permit(:new_comment, :new_rating, :new_comment_followed_story)
  end
end