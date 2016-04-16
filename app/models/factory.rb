class Factory < ActiveRecord::Base
  belongs_to :location
  has_many :items

  has_attached_file :avatar,
                    :storage => :s3,
                    :s3_credentials => {:bucket => "stalkerzona", :access_key_id => "AKIAJXEM5TEGB3D4AJ6Q", :secret_access_key => "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"}

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
