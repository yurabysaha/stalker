class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|

      t.integer :health, default: 100
      t.integer :endurance, default: 50
      t.integer :weight, default: 0
      t.integer :rank, default: 0
      t.integer :reputation, default: 0
      t.integer :money, default: 1000
      t.belongs_to :user, index: true
      t.belongs_to :location, index: true, default: 1

      t.timestamps null: false
    end
  end
end
