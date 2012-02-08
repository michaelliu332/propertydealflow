class DealsTags < ActiveRecord::Migration
  def self.up
    create_table :deals_tags, :id => false do |t|
      t.column :deal_id, :integer
      t.column :tag_id,  :integer
    end
  end

  def self.down
    drop_table :deals_tags
  end
end
