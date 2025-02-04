class ShoppingCart < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    cart.shopping_carts.includes(:product).sum { |item| item.quantity * item.product.price }
  end
  def total_quantity
    cart.shopping_carts.sum(:quantity)
  end
end
