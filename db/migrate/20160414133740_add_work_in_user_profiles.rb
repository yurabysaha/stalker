class AddWorkInUserProfiles < ActiveRecord::Migration
  def change
    add_column :user_profiles, :work_on, :integer
    add_column :user_profiles, :work_end, :datetime
  end
end
