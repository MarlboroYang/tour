class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string, default: 'user'
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
  add_index :users, :name, unique: true
end
