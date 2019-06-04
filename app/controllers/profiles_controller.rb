class ProfilesController < ApplicationController
  layout 'profile'

  def show
    @user = User.find params[:id]
    @stories = Story::Filter.new.filter(params, @user.stories)
  end

  def favorites
    render_profile(:favorited_by)
  end

  def negatives
    render_profile(:negative_by)
  end

  def commented
    render_profile(:commented_by)
  end

  protected

  def render_profile(subject)
    @user = User.find params[:profile_id]
    @stories = Story::Filter.new.filter(params, Story.send(subject, @user))
    render :show
  end
end
