class UpdateDefaultValueForShoppingCart < ActiveRecord::Migration[8.0]
  def change
    change_column_default :shopping_carts, :quantity, from: 1, to: 0
  end
end
