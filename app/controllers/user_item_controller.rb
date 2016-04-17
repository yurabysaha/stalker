class UserItemController < ApplicationController

  def index
    @items = UserItem.where(user_id: current_user.id)

    @user =  UserBody.find_by_user_id(current_user.id)
      if @user.head != nil
        @user_head = UserItem.find(current_user.user_body.head)
      end

      if @user.body != nil
        @user_head = UserItem.find(current_user.user_body.head)
      end
      if @user.hand != nil
        @user_hand = UserItem.find(current_user.user_body.hand)
      end
    if @user.leg != nil
      @user_leg = UserItem.find(current_user.user_body.leg)
    end

=begin
    @user_head = UserItem.find(current_user.user_body.head)
    @user_body = UserItem.find(current_user.user_body.body)
    @user_hand = UserItem.find(current_user.user_body.hand)
    @user_leg = UserItem.find(current_user.user_body.leg)
=end


  end

  def buy
    @item = Item.find(params[:id])
     if current_user.user_profile.money > @item.price
       money_update
      @user_item = UserItem.new()
      copy_params
      if @user_item.save
        redirect_to '/'
      else
        redirect_to '/signup'
      end
     else
       redirect_to :back
       flash[:danger] = "У тебя недостаточно денег"
     end
  end




  def copy_params
    @user_item.name = @item.name
    @user_item.description = @item.description
    @user_item.body_type = @item.body_type
    @user_item.min_lvl = @item.min_lvl
    @user_item.strength = @item.strength
    @user_item.avatar = @item.avatar.url
    @user_item.user_id = current_user.id
  end

  def money_update
    user = UserProfile.find_by_user_id(current_user.id)
    user.update_attribute(:money, user.money - @item.price)
  end

end
