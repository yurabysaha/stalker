class FactoryController < ApplicationController
  before_action :require_user, :on_fight, only: [:index, :new, :show, :work]
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
      factory = Factory.find(params[:id])

      if user.work_end == nil or user.work_end < Time.now
        user.update_attributes(work_on: params[:id], work_end: Time.now + 3600, money: user.money + factory.salary, q_do_work: +1)
        factory.update_attribute(:budget, factory.budget - factory.salary)
        redirect_to '/'
      else
        redirect_to :back
        flash[:danger] = "Вы уже работаете, подождите окончание текущей работы"
      end
    end

    private
    def factory_params
      params.require(:factory).permit(:name, :description, :budget, :salary, :location_id, :avatar)
    end

end
