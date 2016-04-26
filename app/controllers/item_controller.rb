class ItemController < ApplicationController
  before_action :require_user, :on_fight, only: [:factory_items, :new, :show, :create]

  def factory_items
    @items = Item.where(factory_id: params[:id])
  end

  def new

  end

  def show

  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :body_type, :min_lvl, :strength, :amount, :add_health, :add_damage, :factory_id, :avatar)
  end
end
