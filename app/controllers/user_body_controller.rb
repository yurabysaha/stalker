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
    update_user(@item.add_health, @item.add_damage, 'plus')
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
        @item = UserItem.where(id: current_user.user_body.head).first
        @user_body.head = nil
      when "body"
        @item = UserItem.where(id: current_user.user_body.body).first
        @user_body.body = nil
      when "hand"
        @item = UserItem.where(id: current_user.user_body.hand).first
        @user_body.hand = nil
      when "leg"
        @item = UserItem.where(id: current_user.user_body.leg).first
        @user_body.leg = nil
    end
    update_user(@item.add_health, @item.add_damage, 'minus')
    @user_body.save
    redirect_to :back
  end

private

  def update_user(health, damage, action)
    user = UserProfile.where(user_id: current_user.id).first
    case action
      when 'plus'
        user.health += health
        user.damage += damage
      when 'minus'
        user.health -= health
        user.damage -= damage
    end
    user.save
  end
end
