class CreateValues < ActiveRecord::Migration
  def self.up
    create_table :values, :id => false do |t|
      t.string :key
      t.string :value
    end
    add_index :values, :key
  end

  def self.down
    drop_table :values
  end
end
