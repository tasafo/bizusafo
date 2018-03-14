class StoriesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!, except: :show

  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = current_user.stories.build
    @story.comments.build
  end

  def create
    @story = Story.create_story! user: current_user, params: new_story_params

    if @story.persisted?
      redirect_to root_path, :notice => "Bizu criado com sucesso!"
    else
      @story.comments.build if @story.comments.blank?
      render :new
    end
  end

  def edit
    @story = current_user.stories.find(params[:id])
  end

  def update
    @story = current_user.stories.find(params[:id])

    if @story.update_attributes story_params
      redirect_to root_path, :notice => "Bizu alterado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @story = current_user.stories.find(params[:id])
    @story.destroy

    redirect_to root_path, :notice => "Bizu excluido com sucesso!"
  end

  def positive
    render json: { success: get_story.add_positive_rating!(current_user) }
  end

  def negative
    render json: { success: get_story.add_negative_rating!(current_user) }
  end

  private

  def get_story
    @story = Story.find(params[:story_id])
  end

  def new_story_params
    params.require(:story).permit(:description, :url, :tag_list, :comments_attributes => [:text, :commentable_type, :commentable_id, :author_id])
  end

  def story_params
    params.require(:story).permit(:description, :url, :tag_list)
  end
end
