class CreateChunks < ActiveRecord::Migration
  def self.up
    create_table :chunks do |t|
      t.column(:client, :string)
      t.column(:client_email, :string)
      t.column(:client_contact_name, :string)
      t.column(:author, :string)
      t.column(:description, :text)
      t.column(:upload_date, :datetime)
      t.column(:expire_date, :date)
      t.column(:filename, :string)
      t.column(:download_count, :integer)
      t.column(:download_count_max, :integer)
      t.timestamps
    end
  end

  def self.down
    drop_table :chunks
  end
end
