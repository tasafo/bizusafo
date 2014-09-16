require 'spec_helper'

describe Api::V1::StoriesController do
  fixtures :users

  let(:valid_params) do
    { url: "http://google.com",
      description: "Search on google",
      comment_text: { text: "New comment" } }
  end

  let(:invalid_params) { { url: nil, description: nil } }

  let(:user) { users(:john) }

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  before do
    @request.headers["ACCEPT"] = Mime::JSON
  end

  describe "POST create" do
    context "with valid authentication" do
      before do
        @request.headers["HTTP_AUTHORIZATION"] = token_header(user.auth_token)
      end

      context "with valid params" do
        it "creates new story" do
          expect {
            post :create, story: valid_params
          }.to change{ Story.count }.by(1)

          expect(Story.last.user).to eql user
          expect(response.status).to eql 201
          expect(JSON.parse(response.body)["url"]).to eql valid_params[:url]
        end
      end

      it "saves comment with current user as author" do
        post :create, story: valid_params

        comment = Story.last.comments.last
        expect(comment.author).to eql user
      end

      context "with invalid params" do
        it "responds unprocesses entity" do
          expect {
            post :create, story: invalid_params
          }.to change{ Story.count }.by(0)

          expect(response.status).to eql 422

          invalid_story = Story.new
          invalid_story.valid?
          expect(JSON.parse(response.body)).to eql invalid_story.errors.full_messages
        end
      end
    end

    context "with invalid authentication" do
      it "responds unauthorized" do
        expect {
          @request.headers["HTTP_AUTHORIZATION"] = token_header("wrong token")
          post :create, story: valid_params
        }.to change{ Story.count }.by(0)

        expect(response.status).to eql 401
      end
    end
  end
end
