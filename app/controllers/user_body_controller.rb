class UserBodyController < ApplicationController

  def add_item
    @item = UserItem.find(params[:id])
    @user_body = UserBody.find_by_user_id(current_user.id)
    case @item.body_type
      when "head"
        @user_body.hand = @item.id
      when "body"
        @user_body.body = @item.id
      when "hand"
        @user_body.hand = @item.id
      when "leg"
        @user_body.leg = @item.id
    end
    @user_body.save
    redirect_to :back
  end

end
