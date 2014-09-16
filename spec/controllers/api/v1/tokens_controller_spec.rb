require 'spec_helper'

describe Api::V1::TokensController do
  fixtures :users

  let(:user) { users(:john) }
  
  before do
    @request.headers["ACCEPT"] = Mime::JSON
  end

  describe "POST create" do
    context "when credentials match" do

      before do
        user.update(password: "12345678", password_confirmation: "12345678")
      end

      context "when user has no token" do
        it "generates new token to user" do
          user.update auth_token: nil

          expect(user.auth_token).to be_blank

          post :create, user: { email: user.email, password: "12345678" }
          
          expect(response.status).to eql 200
          expect(user.reload.auth_token).to be_present
          expect(JSON.parse(response.body)["token"]).to eql user.auth_token
        end
      end

      context "when user already has a token" do
        it "returns token" do
          old_token = user.auth_token

          post :create, user: { email: user.email, password: "12345678" }
          
          expect(response.status).to eql 200
          expect(JSON.parse(response.body)["token"]).to eql old_token
        end
      end
    end

    context "when credentials do not match" do
      it "with wrong password responds unauthorized" do
        post :create, user: { email: user.email, password: "wrongPass" }
      
        expect(response.status).to eql 401
        expect(response.body).to be_blank
      end

      it "with wrong email responds unauthorized" do
        post :create, user: { email: "wrong@email.com", password: "12345678" }
      
        expect(response.status).to eql 401
        expect(response.body).to be_blank
      end
    end
  end
end