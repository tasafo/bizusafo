class ProfilesController < ApplicationController
  layout 'profile'

  def show
    @user = User.find params[:id]
    @stories = Story::Filter.new.filter(params, @user.stories)
  end
end
