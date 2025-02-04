class AddNameToVendors < ActiveRecord::Migration[8.0]
  def change
    add_column :vendors, :name, :string
    add_column :vendors, :description, :string
  end
end
