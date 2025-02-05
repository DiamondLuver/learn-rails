class Cart < ApplicationRecord
  belongs_to :user
  has_many :shopping_carts
  has_many :products, through: :shopping_carts


  def add_product(product, quantity)
    item = shopping_carts.find_or_initialize_by(product: product, is_completed: 0)
    check_qtn = item.quantity + quantity
    if check_qtn > product.quantity
      return false
    end
    item.quantity += quantity
    item.save
  end

  def total_price
    # shopping_carts.sum { |item| item.quantity * item.product.price }
    # shopping_carts.sum(&:products.price)
  end

  def remove_product(product)
    item = shopping_carts.find_by(product: product)
    item.destroy
  end

  def checkout_order
    shopping_carts.each do |item|
      product = item.product
      product.quantity -= item.quantity
      product.save
      item.is_completed = true
      item.save
    end
    self.status = 2
    self.save
    # shopping_carts.destroy_all
  end

  def get_shopping_carts
    shopping_carts.where(is_completed: false) 
  end
  def get_products
    self.shopping_carts.includes(:product).where(is_completed: false).map(&:product)
  end
end
