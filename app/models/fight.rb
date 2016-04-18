class Fight < ActiveRecord::Base
  belongs_to :user
  belongs_to :opponent, :class_name => "User", :foreign_key =>'opponent_id'
end
