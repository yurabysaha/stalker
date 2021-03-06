class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|

      t.string :name
      t.string :description
      t.integer :price
      t.string :body_type
      t.integer :min_lvl
      t.integer :strength
      t.integer :amount
      t.integer :add_health
      t.integer :add_damage
      t.integer :add_weight
      t.belongs_to :factory, index: true

      t.timestamps null: false
    end
  end
end
