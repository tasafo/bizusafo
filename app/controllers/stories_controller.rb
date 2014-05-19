class StoriesController < ApplicationController

  before_action :authenticate_user!

  def new
    @story = current_user.stories.build
  end

  def create
    @story = current_user.stories.build story_params

    if @story.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def story_params
    params.require(:story).permit([:description, :url])
  end
end
