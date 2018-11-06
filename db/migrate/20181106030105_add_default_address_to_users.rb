class AddDefaultAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :default_address_id, :integer
    remove_column :users, :address
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zip
  end
end
