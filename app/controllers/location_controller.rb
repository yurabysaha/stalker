class LocationController < ApplicationController
  before_action :require_user, :on_fight, only: [:index, :new, :show, :create]


  def index
    @locations = Location.all
    @current_location = Location.find(current_user.user_profile.location_id)
  end

  def new

  end

=begin
     Змінюється локація тут. Якщо нам приходить що ajax то ми грузимо тімер до переходу залишилось.
     Інакше показуємо html (Значить юзер клікнув на 'Локации')
=end
  def show
    current_location = Location.find(params[:id])
    new_location = UserProfile.find_by_user_id(current_user.id)
    new_location.update_attribute(:location_id, current_location.id)
    respond_to do |format|
      format.html { redirect_to '/location' }
      format.js {}
    end
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private
  def location_params
    params.require(:location).permit(:name, :description)
  end
end
