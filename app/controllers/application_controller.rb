class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :on_fight

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def require_user
    redirect_to '/' unless current_user
  end


  def on_fight
    if @current_user.user_profile.on_fight != nil
      redirect_to battle_path(@current_user.user_profile.on_fight)
      end
    end
end
