class CreateUserBodies < ActiveRecord::Migration
  def change
    create_table :user_bodies do |t|

      t.integer :head
      t.integer :body
      t.integer :hand
      t.integer :leg
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
