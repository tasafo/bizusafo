class ProfilesController < ApplicationController
  layout 'profile'

  def show
    @user = User.find params[:id]
    @stories = Story::Filter.new.filter(params, @user.stories)
  end

  def favorites
    @user = User.find params[:profile_id]
    @stories = Story::Filter.new.filter(params, Story.favorited_by(@user))
    render :show
  end

  def negatives
    @user = User.find params[:profile_id]
    @stories = Story::Filter.new.filter(params, Story.negative_by(@user))
    render :show
  end

  def commented
    @user = User.find params[:profile_id]
    @stories = Story::Filter.new.filter(params, Story.commented_by(@user))
    render :show
  end
end
