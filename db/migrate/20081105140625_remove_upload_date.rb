class RemoveUploadDate < ActiveRecord::Migration
  def self.up
    remove_column :chunks, :upload_date
  end

  def self.down
    add_column :chunks, :upload_date, :datetime
  end
end
