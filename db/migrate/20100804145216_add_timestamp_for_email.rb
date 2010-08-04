class AddTimestampForEmail < ActiveRecord::Migration
  def self.up
    add_column :users, :email_times, :date
  end

  def self.down
  end
end
