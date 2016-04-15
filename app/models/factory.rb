class Factory < ActiveRecord::Base
  belongs_to :location

  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


end
