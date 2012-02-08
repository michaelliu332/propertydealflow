class AddUserIdToDeals < ActiveRecord::Migration
  def self.up
    add_column :deals, :user_id, :integer
  end

  def self.down
    remove_column :deals, :user_id
  end
end
