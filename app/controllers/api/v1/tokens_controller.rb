class Api::V1::TokensController < ApiController
  def create
    user = User.find_by(email: user_params[:email])
    user = user && user.valid_password?(user_params[:password]) ? user : nil

    if user && user.auth_token.blank?
      user.auth_token = generate_auth_token
      user.save
    end

    respond_to do |format|
      if user
        format.json { render :json => { token: user.auth_token } }
      else
        format.json { render :json => "", status: 401 }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def generate_auth_token
    loop do
      token = SecureRandom.hex
      break token unless User.exists? auth_token: token
    end
  end
end