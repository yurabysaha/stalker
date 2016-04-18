class ItemController < ApplicationController

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
    params.require(:item).permit(:name, :description, :price, :body_type, :min_lvl, :strength, :amount, :factory_id, :avatar)
  end
end
