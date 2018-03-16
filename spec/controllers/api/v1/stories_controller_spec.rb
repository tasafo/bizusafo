require 'rails_helper'

describe Api::V1::StoriesController, type: :controller do
  let(:valid_params) do
    { url: "http://google.com",
      description: "Search on google",
      comment_text: { text: "New comment" } }
  end

  let(:invalid_params) { { url: nil, description: nil } }

  let(:user) { users(:john) }

  let(:parsed_response) { JSON.parse(response.body) }

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  before do
    @request.headers["ACCEPT"] = Mime[:json]
  end

  describe "GET index" do
    context "without credentials" do
      context "and without stories" do
        before do
          Story.destroy_all
        end

        it "returns empty list" do
          get :index
          expect(parsed_response["stories"]).to be_empty
          expect(parsed_response["message"]).to eql I18n.t("story.no_story")
        end
      end

      context "when we have stories" do
        it "returns a list" do
          get :index
          expect(parsed_response["stories"].size).to be >= 3
          expect(parsed_response["message"]).to eql ""
        end
      end
    end

    context "with valid credentials" do
      before do
        @request.headers["HTTP_AUTHORIZATION"] = token_header(user.auth_token)
      end

      context "when don't have stories" do
        before do
          Story.destroy_all
        end

        it "returns empty list" do
          get :index
          expect(parsed_response["stories"]).to be_empty
          expect(parsed_response["message"]).to eql I18n.t("story.no_story")
        end
      end

      context "when we have stories" do
        it "returns a list" do
          get :index
          expect(parsed_response["stories"].size).to be >= 3
          expect(parsed_response["message"]).to eql ""
        end
      end
    end
  end

  describe "POST create" do
    context "with valid authentication" do
      before do
        @request.headers["HTTP_AUTHORIZATION"] = token_header(user.auth_token)
      end

      context "with valid params" do
        it "creates new story" do
          expect {
            post :create, params: { story: valid_params }
          }.to change{ Story.count }.by(1)

          story = stories(:how_to)

          expect(story.user).to eql user
          expect(response.status).to eql 201
          expect(parsed_response["url"]).to eql valid_params[:url]
        end
      end

      context "without comment text" do
        it "saves story without errors" do
          post :create, params: { story: valid_params.merge(comment_text: "") }

          expect(Story.last.comments).to be_empty
          expect(response.status).to eql 201
        end
      end

      it "saves comment with current user as author" do
        post :create, params: { story: valid_params }

        comment = Story.last.comments.last
        expect(comment.author).to eql user
      end

      context "with invalid params" do
        it "responds unprocesses entity" do
          expect {
            post :create, params: { story: invalid_params }
          }.to change{ Story.count }.by(0)

          expect(response.status).to eql 422

          invalid_story = user.stories.new
          invalid_story.valid?
          expect(parsed_response).to eql invalid_story.errors.full_messages
        end
      end
    end

    context "with invalid authentication" do
      it "responds unauthorized" do
        expect {
          @request.headers["HTTP_AUTHORIZATION"] = token_header("wrong token")
          post :create, params: { story: valid_params }
        }.to change{ Story.count }.by(0)

        expect(response.status).to eql 401
      end
    end
  end
end
