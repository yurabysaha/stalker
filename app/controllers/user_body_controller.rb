class UserBodyController < ApplicationController
  before_action :require_user, :on_fight, only: [:add_item, :down_item]

=begin
  add_item. Одягнути ітем на Юзера.Отримуємо ІD Item який хочемо надіти.
 Спочатку шукаємо цей Item.
Далі шукаємо User_body на яке хочемо надіти айтем(карент юзера)
Далі дивимось який тип цього Itemа і надіваємо на цю частину.
=end

  def add_item
    @item = UserItem.find(params[:id])
    @user_body = UserBody.find_by_user_id(current_user.id)
    case @item.body_type
      when "head"
        @user_body.head = @item.id
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

=begin
down_item. Шукаємо тіло Юзера. По параметру дивимось який айтем знімати
=end
  def down_item
    @user_body = UserBody.find_by_user_id(current_user.id)
    case params[:type]
      when "head"
        @user_body.head = nil
      when "body"
        @user_body.body = nil
      when "hand"
        @user_body.hand = nil
      when "leg"
        @user_body.leg = nil
    end
    @user_body.save
    redirect_to :back
  end

end
