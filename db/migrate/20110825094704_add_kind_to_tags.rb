class AddKindToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :kind, :string
  end

  def self.down
    remove_column :tags, :kind
  end
end
