class Product < ApplicationRecord
  has_many :shopping_carts
  has_many :carts, through: :shopping_carts
  belongs_to :vendor
  after_create :check_quantity

  def check_quantity
    if self.quantity <= 0
      self.destroy
    end
    # if self.quantity < 5
      # ProductMailer.with(product: self).low_stock_email.deliver_now
    # end
    if self.quantity.nil?
      self.quantity = 1
    end
  end
end
