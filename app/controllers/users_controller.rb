class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    respond_with user, location: -> { new_session_path }
  end

  def show
  end

  def edit
  end

  def update
    user.update_attributes(user_params)

    respond_with(user)
  end

  def destroy
    user.delete

    respond_with user, location: -> { new_user_path }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :uid)
  end

  def user
    @user ||= User.find(params[:id])
  end
  helper_method :user
end
