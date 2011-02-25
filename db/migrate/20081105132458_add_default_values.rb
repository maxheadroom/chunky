class AddDefaultValues < ActiveRecord::Migration
  def self.up
    remove_column :chunks, :download_count
    add_column :chunks, :download_count , :integer, :default => 0
  end

  def self.down
    remove :chunks, :download_count
    add_column :chunks, :download_count, :integer
  end
end
