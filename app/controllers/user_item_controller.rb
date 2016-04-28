class UserItemController < ApplicationController
  before_action :require_user, :on_fight, only: [:index, :buy]

  def index
    @items = UserItem.where(user_id: current_user.id)

    @user =  UserBody.find_by_user_id(current_user.id)
      if @user.head != nil
        @user_head = UserItem.find(current_user.user_body.head)
      end
      if @user.body != nil
        @user_body = UserItem.find(current_user.user_body.body)
      end
      if @user.hand != nil
        @user_hand = UserItem.find(current_user.user_body.hand)
      end
      if @user.leg != nil
        @user_leg = UserItem.find(current_user.user_body.leg)
      end
  end

  def buy
    @item = Item.find(params[:id])
     if current_user.user_profile.money >= @item.price
       profile_update_money_and_weight
       @item.amount = @item.amount - 1
       @item.save
      @user_item = UserItem.new()
      copy_params
      if @user_item.save
        redirect_to :back
        flash[:success] = "Предмет появится у тебя в инвентаре"
      else
        redirect_to '/signup'
      end
     else
       redirect_to :back
       flash[:danger] = "У тебя недостаточно денег"
     end
  end


 private

  def copy_params
    @user_item.name = @item.name
    @user_item.description = @item.description
    @user_item.body_type = @item.body_type
    @user_item.min_lvl = @item.min_lvl
    @user_item.strength = @item.strength
    @user_item.add_health = @item.add_health
    @user_item.add_damage = @item.add_damage
    @user_item.add_weight = @item.add_weight
    @user_item.avatar = @item.avatar.url
    @user_item.user_id = current_user.id
  end

  def profile_update_money_and_weight
    user = UserProfile.find_by_user_id(current_user.id)
    user.update_attributes(:money => user.money - @item.price, :weight => user.weight + @item.add_weight)
  end

end
