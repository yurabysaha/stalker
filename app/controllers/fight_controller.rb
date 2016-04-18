class FightController < ApplicationController
  def index
    @fights = Fight.all
  end

  def new

  end
=begin
Метод create. Тут виконується ф-ція Создать. Спочатку перевіряємо чи Юзер немає активних заявок
Якщо ні то створюємо нову і оновлюємо сторінку Арени
=end
  def create
    if Fight.find_by_user_id(current_user.id) == nil
     @fight = Fight.new(fight_params)
      if @fight.save
       redirect_to '/fight'
      else
       redirect_to :back
       flash[:danger] = "Произошла ошибка, бой не создан"
      end
    else
      redirect_to :back
      flash[:danger] = "Cтрелка уже назначена"
    end
  end

=begin
  Метод Update. Тут виконується функція Вступить. Спочатку перевіряється чи у Юзера нема активної заявки, якщо є видаляємо її
бо юзер не може мати два бої одночасно. Потім шукаємо по ID бій до якого Юзер хоче приєднатись, оновлюємо його додаючи
ID Юзера в опоненти
=end
  def update
    if Fight.find_by_user_id(current_user.id) != nil
      destroy
    end
      @fight = Fight.find(params[:id])
      @fight.opponent_id = params[:opponent]
      @fight.save
      redirect_to :back
  end

  def destroy
    Fight.find_by_user_id(current_user.id).destroy
  end

  private
  def fight_params
    params.permit(:user_id, :opponent_id, :who_move)
  end
end
