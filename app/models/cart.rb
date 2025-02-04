class Cart < ApplicationRecord
  belongs_to :user
  has_many :shopping_carts
  has_many :products, through: :shopping_carts

  def add_product(product)
    item = shopping_carts.find_or_initialize_by(product: product)
    item.save
  end
  def total_price
    shopping_carts.sum(&:total_price)
  end

  def remove_product(product)
    item = shopping_carts.find_by(product: product)
    item.destroy
  end
end
