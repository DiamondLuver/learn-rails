class Cart < ApplicationRecord
  belongs_to :user
  has_many :shopping_carts
  has_many :products, through: :shopping_carts

  enum status: { pending: 0, checkout: 1, payment: 2, completed: 3 }


  def add_product(product, quantity)
    item = shopping_carts.find_or_initialize_by(product: product)
    if item.quantity + quantity > product.quantity
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
    end
    self.status = :checkout
    update(status: :checkout)
    # shopping_carts.destroy_all
  end

  def get_shopping_carts
    shopping_carts.where(is_completed: false) 
  end
end
