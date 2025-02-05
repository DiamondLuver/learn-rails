class AddStatusToCarts < ActiveRecord::Migration[8.0]
  def change
    add_column :carts, :status, :integer, :default => 1
    # add_column :carts, :status, :integer, default: 0

  end
end
