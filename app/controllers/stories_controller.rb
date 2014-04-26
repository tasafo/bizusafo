class StoriesController < ApplicationController
  def new
    @story = Story.new
  end

  def create
    @story = Story.new story_params

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
