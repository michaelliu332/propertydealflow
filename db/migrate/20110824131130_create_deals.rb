class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.string :content
      
      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
