class CreateFights < ActiveRecord::Migration
  def change
    create_table :fights do |t|

      t.integer :user_id, :opponent_id
      t.integer :bet,       default: 0
      t.integer :who_move,  default: 0
      t.integer :player1_health
      t.integer :player2_health
      t.string  :player1_hit
      t.string  :player2_hit
      t.string  :player1_move
      t.string  :player2_move
      t.text    :description, default: '<br>'
      t.integer :raund, default: 1
      t.integer :win

      t.timestamps null: false
    end
  end
end
