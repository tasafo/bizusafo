class ProfilesController < ApplicationController
  layout 'profile'

  before_action :authenticate_user!

  def show
    @stories = Story::Filter.new.filter(params, current_user.stories)
  end
end
