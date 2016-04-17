class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      @user_profile = UserProfile.new(:user_id => current_user.id)
      @user_profile.save
      @user_body = UserBody.new(:user_id => current_user.id)
      @user_body.save
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end


  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Профіль успішно оновлено"
      redirect_to '/'
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    if @user.destroy
      session[:user_id] = nil
      redirect_to '/'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :mail, :password, :password_confirmation)
  end
end