class AddTweetIdToDeals < ActiveRecord::Migration
  def self.up
    add_column :deals, :tweet_id, :string
    add_index :deals, :tweet_id
  end

  def self.down
    remove_column :deals, :tweet_id
  end
end