class FactoryController < ApplicationController
    def index

    end

    def new

    end
    def show
      @factory = Factory.find(params[:id])
    end
    def create
      @factory = Factory.new(factory_params)
      if @factory.save
        redirect_to '/'
      else
        redirect_to '/signup'
      end
    end

    def work
      user = UserProfile.find_by_user_id(current_user.id)
      user.update_attributes(work_on: params[:id], work_end: Time.now + 3600)
      redirect_to '/'
    end

    private
    def factory_params
      params.require(:factory).permit(:name, :description, :budget, :salary, :location_id)
    end

end
