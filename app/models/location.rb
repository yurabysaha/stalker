class Location < ActiveRecord::Base
  has_many :factories
  has_many :user_profiles
end
