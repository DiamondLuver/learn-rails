class AddQuantityToShoppingCarts < ActiveRecord::Migration[8.0]
  def change
    add_column :shopping_carts, :quantity, :float, :default => 1
  end
end
