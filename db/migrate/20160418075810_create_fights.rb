class CreateFights < ActiveRecord::Migration
  def change
    create_table :fights do |t|
      t.integer :user_id, :opponent_id
      t.integer :who_move
      t.timestamps null: false
    end
  end
end
