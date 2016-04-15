class UserProfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :location


  def work_on_factory
    Factory.find(work_on)
  end
end
