class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create]
  before_action :authorize_admin!, only: [:index, :show, :update]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorize_user!, only: [:destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users.as_json(except: [:password_digest])
  end

  def me 
    render json: current_user.as_json(except: [:password_digest, :admin])
  end

  # GET /users/1
  def show
    render json: @user.as_json(except: [:password_digest, :admin])
  end

  # POST /users
  def create
    @user = User.new(create_user_params)

    if @user.save
      render json: @user.as_json(except: [:password_digest]), status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(update_user_params)
      render json: @user.as_json(except: [:password_digest, :admin])
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_me
    if current_user.update(update_user_params)
      render json: current_user.as_json(except: [:password_digest, :admin])
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  def update_password
    if current_user && current_user.authenticate(password_params[:current_password])
      if current_user.update(password: password_params[:password])
        render json: { message: "Password updated successfully" }
      else
        render json: current_user.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Current password is incorrect" }, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    render json: { message: 'User deleted successfully' }
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def create_user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def update_user_params
      params.require(:user).permit(:name, :email)
    end

    def password_params
      params.require(:user).permit(:current_password, :password)
    end
end
