class AddAttachmentAvatarToFactories < ActiveRecord::Migration
  def self.up
    change_table :factories do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :factories, :avatar
  end
end
