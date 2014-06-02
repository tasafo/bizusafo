class StoriesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!

  def show
    @story = Story.find(params[:id])
  end

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

  def edit
    @story = current_user.stories.find(params[:id])
  end

  def update
    @story = current_user.stories.find(params[:id])

    if @story.update_attributes story_params
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @story = current_user.stories.find(params[:id])
    @story.destroy

    redirect_to root_path
  end

  def positive
    if get_story.ratings.create(:user => current_user, :positive => true)
      render json: { success: true }
    end
  end

  def negative
    if get_story.ratings.create :user => current_user, :positive => false
      render json: { success: true }
    end
  end

  private

  def get_story
    @story = Story.find(params[:story_id])
  end

  def story_params
    params.require(:story).permit([:description, :url])
  end
end
