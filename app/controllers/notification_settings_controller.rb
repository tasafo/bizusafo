class NotificationSettingsController < ApplicationController
  def update
    @setting = current_user.notification_setting
    
    if @setting.update_attributes(notification_params)
      redirect_to edit_user_registration_path, notice: I18n.t("notification_setting.update") 
    else
      redirect_to edit_user_registration_path, alert: I18n.t("notification_setting.error")
    end
  end

  protected

  def notification_params
    params.require(:notification_setting).permit(:new_comment, :new_rating, :new_comment_followed_story)
  end
end