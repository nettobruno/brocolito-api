class AuthenticationController < ApplicationController
  def login
    user = User.find_by(email: authentication_params[:email])

    if user&.authenticate(authentication_params[:password])
      token = JsonWebToken.encode(user_id: user.id)

      render json: {
        token: token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email
        }
      }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def authentication_params
    params.require(:authentication).permit(:email, :password)
  end
end