class CreateUserItems < ActiveRecord::Migration
  def change
    create_table :user_items do |t|

      t.string :name
      t.string :description
      t.string :body_type
      t.integer :min_lvl
      t.integer :strength
      t.integer :add_health
      t.integer :add_damage
      t.integer :add_weight
      t.string :avatar
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
