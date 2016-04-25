class UserProfileController < ApplicationController
  before_action :require_user, :on_fight, only: [:show]

  def show
    @user = User.find(params[:id])
  end
end
