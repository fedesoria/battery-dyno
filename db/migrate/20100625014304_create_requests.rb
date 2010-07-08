class CreateRequests < ActiveRecord::Migration
  def self.up    
    create_table :requests do |t|
      t.datetime    "date"
      t.float       "start"
      t.float       "stop"
      t.integer     "dynos", :default => 1
      t.references  :user
      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
