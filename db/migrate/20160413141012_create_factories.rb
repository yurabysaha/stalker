class CreateFactories < ActiveRecord::Migration
  def change
    create_table :factories do |t|
      t.string :name
      t.string :description
      t.integer :budget
      t.integer :salary
      t.belongs_to :location, index: true

      t.timestamps null: false
    end
  end
end
