class Api::V1::StoriesController < ApiController
  before_filter :authenticate

  def index
    @stories = Story.all

    respond_to do |format|
      message = @stories.present? ? "" : I18n.t("story.no_story")
      format.json {render json: {stories: @stories, message: message}}
    end
  end

  def create
    @story = @user.stories.build(new_story_params)
    @story.comments.build(text: params[:story][:comment_text], author: @user) if params[:story][:comment_text].present?

    respond_to do |format|
      if @story.save
        format.json { render json: @story, status: 201 }
      else
        format.json { render json: @story.errors.full_messages, status: 422 }
      end
    end
  end

  private

  def new_story_params
    params.require(:story).permit(:description, :url, :tag_list)
  end

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @user = User.find_by(auth_token: token)
    end
  end

  def render_unauthorized
    respond_to do |format|
      format.json { render json: "Bad credentials", status: 401 }
    end
  end
end
