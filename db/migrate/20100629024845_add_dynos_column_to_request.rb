class AddDynosColumnToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :dynos, :integer
    remove_column :users, :dynos
  end

  def self.down
    remove_column :requests, :dynos
  end
end
