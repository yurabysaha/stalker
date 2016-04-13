class User < ActiveRecord::Base

  validates :mail, presence: true,
            uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true,
            confirmation: true,
            length: { in: 6..20 }, allow_nil: true

  has_secure_password

  has_one :user_profile


end