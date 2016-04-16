class Factory < ActiveRecord::Base
  belongs_to :location
  has_many :items

  has_attached_file :avatar,
      storage: :s3,
         s3_credentials: {access_key_id: ENV["AKIAJXEM5TEGB3D4AJ6Q"], secret_access_key: ENV["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"]},
        bucket: "stalkerzona"

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


end
