class SessionsController < ApplicationController
  def index

  end

  def new
  end

  def create
    @user = User.find_by_mail(params[:session][:mail])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:danger] = "Неправильна пошта або пароль"
      redirect_to '/'
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end