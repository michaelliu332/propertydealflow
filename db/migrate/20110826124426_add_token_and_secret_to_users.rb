class AddTokenAndSecretToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :token, :string
    add_column :users, :secret, :string
  end

  def self.down
    remove_columns :users, :token, :secret
  end
end
