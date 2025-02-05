class AddIsCompletedToShoppingCarts < ActiveRecord::Migration[8.0]
  def change
    add_column :shopping_carts, :is_completed, :boolean, :default => false
  end
end
