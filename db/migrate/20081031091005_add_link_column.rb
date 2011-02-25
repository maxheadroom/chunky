class AddLinkColumn < ActiveRecord::Migration
  def self.up
    add_column :chunks, :link, :string 
  end

  def self.down
      remove_column :chunks, :link
  end
end
