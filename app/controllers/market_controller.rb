class MarketController < ApplicationController


  def index
     @items = UserItem.where('in_market = ?', true)
     @items = @items.where(body_type: params[:type]) if params[:type]
     @items = @items.order("name #{params[:name]}") if params[:name]
     @items = @items.order("price #{params[:price]}") if params[:price]
     @items = @items.order("strength #{params[:strength]}") if params[:strength]
     @items = @items.order("min_lvl #{params[:min_lvl]}") if params[:min_lvl]
     @items = @items.where(name: params[:item_name]) if params[:item_name]
  end

  def buy_on_market
    @item = UserItem.find(params[:id])
    if @item.in_market == true
      if @item.user_id != current_user.id
        if current_user.user_profile.money >= @item.price
          seller = UserProfile.where(id: @item.user_id).first
          seller.money += @item.price
          seller.q_sold_on += @item.price
          seller.weight -= @item.add_weight
          seller.save
          buyer = current_user.user_profile
          buyer.money -= @item.price
          buyer.weight += @item.add_weight
          buyer.save
          @item.update_attributes(user_id: current_user.id, in_market: false, price: 0)
          redirect_to :back
          flash[:success] = "Предмет появится у тебя в инвентаре"
        else
          redirect_to :back
          flash[:danger] = "У тебя недостаточно денег"
        end
      else
        redirect_to :back
        flash[:danger] = "Eто же твой предмет"
      end
    else
      redirect_to :back
      flash[:danger] = "Eтот предмет уже кто-то купил"
    end
  end

  def sort_item(par, type)
    @items = @items.order("#{par} #{type}")
  end
end
