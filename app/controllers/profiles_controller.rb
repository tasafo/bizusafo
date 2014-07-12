class ProfilesController < ApplicationController
  layout 'profile'

  before_action :authenticate_user!

  def show
    params[:filter] = :timeline if params[:filter].blank?
    @stories = Story::Filter.new.filter(params, current_user.stories)
  end
end
