class FightController < ApplicationController
  before_action :require_user, only: [:index, :new, :create, :update, :destroy, :battle, :on_fight]
  before_action :on_fight, only: [:index]
  def index
    @fights = Fight.all.order(created_at: :desc)
  end

#Тут викликається форма для ставки
  def new
    respond_to do |format|
      format.js {}
    end
  end

=begin
Метод create. Тут виконується ф-ція Создать. Спочатку перевіряємо чи Юзер немає активних заявок
Якщо ні то створюємо нову і оновлюємо сторінку Арени
=end
  def create
    if current_user.user_profile.money < params[:fight][:bet].to_i
        redirect_to :back
        flash[:danger] = "У тебя недостаточно денег"
    else
      if Fight.find_by_user_id(current_user.id) == nil
        @fight = Fight.new(fight_params)
        @fight.user_id = current_user.id
          if @fight.save
            redirect_to '/fight'
          else
            redirect_to :back
            flash[:danger] = "Произошла ошибка, бой не создан"
          end
      else
        destroy
        redirect_to :back
      end
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
    if current_user.user_profile.money < @fight.bet
        redirect_to :back
        flash[:danger] = "У тебя недостаточно денег"
    else
      @fight.opponent_id = params[:opponent]
      @fight.save
      in_battle(@fight.id)
      start_fight
      redirect_to battle_path
    end
  end

  def destroy
    Fight.find_by_user_id(current_user.id).destroy
  end

  def battle
    @fight = Fight.find(params[:id])
    @player1 = @fight.user
    @player2 = @fight.opponent
      if params[:battle] == nil
      else
        if current_user == @player1
            pl1 = params.require(:battle).permit(:hit, :move)
            @fight.player1_hit = pl1[:hit]
            @fight.player1_move = pl1[:move]
            @fight.who_move = @player2.id
        else
            pl2 = params.require(:battle).permit(:hit, :move)
            @fight.player2_hit = pl2[:hit]
            @fight.player2_move = pl2[:move]
            @fight.who_move = @player1.id
        end
        @fight.save

      if raund_end == true
        who_win
      end
      end
    render 'battle'
  end

# Ф-ція убежать с поля боя.
def end
  @fight = Fight.find(params[:id])
  if @fight.user == current_user
    @fight.win = @fight.opponent.id
  else
    @fight.win = @fight.user.id
  end
  in_battle(nil)
  @fight.save
  prize
  redirect_to '/'
  flash[:danger] = "Вы убежали с боя"
end

  private

  def start_fight
    @player1 = @fight.user
    @player2 = @fight.opponent
    @fight.player1_health = @fight.user.user_profile.health
    @fight.player2_health = @fight.opponent.user_profile.health
    @fight.who_move = @fight.user.id
    @fight.save
    bet_from_user
  end

 def raund_end
   if @fight.player1_hit and @fight.player2_hit != nil
      true
   else
     false
   end
 end

  def who_win
    if @fight.player1_hit == @fight.player2_move
       @fight.player2_health = @fight.player2_health - @fight.user.user_profile.damage
       talk = 'Раунд ' + @fight.raund.to_s + ': ' + @player1.name + ' метким вистрелом в грудь ранил противника и нанес ' + @fight.user.user_profile.damage.to_s + ' урона <br>'
       @fight.description = @fight.description + talk
    end
    if @fight.player2_hit == @fight.player1_move
       @fight.player1_health = @fight.player1_health - @fight.opponent.user_profile.damage
       talk = 'Раунд ' + @fight.raund.to_s + ': ' + @player2.name + ' метким вистрелом в грудь ранил противника и нанес ' + @fight.opponent.user_profile.damage.to_s + ' урона <br>'
       @fight.description = @fight.description + talk
    end
       @fight.raund = @fight.raund + 1
       @fight.player1_hit, @fight.player2_hit, @fight.player1_move, @fight.player2_move = nil
    game_end
    @fight.save
  end

  def in_battle(parameter)
    player1 = UserProfile.find(@fight.user_id)
    player1.update_attribute(:on_fight, parameter)
    player2 = UserProfile.find(@fight.opponent_id)
    player2.update_attribute(:on_fight, parameter)
  end
  def game_end
    if @fight.player1_health <= 0
        @fight.win = @player2.id
        in_battle(nil)
        prize
    end
    if @fight.player2_health <= 0
        @fight.win = @player1.id
        in_battle(nil)
        prize
    end
  end
  def bet_from_user
    user1 = UserProfile.find(@fight.user.id)
    user2 = UserProfile.find(@fight.opponent.id)
    user1.money = user1.money - @fight.bet
    user2.money = user2.money - @fight.bet
    user1.save
    user2.save
  end
def prize
    winner = UserProfile.where(user_id: @fight.win).first
    winner.update_attributes(money: winner.money + @fight.bet * 2, q_kill_stalker: +1, reputation: +100)
end
  def fight_params
    params.require(:fight).permit(:user_id, :opponent_id, :bet)
  end
end
