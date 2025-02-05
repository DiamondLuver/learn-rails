class Product < ApplicationRecord
  has_many :shopping_carts, dependent: :destroy
  has_many :carts, through: :shopping_carts
  belongs_to :vendor
  before_update :check_quantity

  def check_quantity
    if self.quantity <= 0
      self.destroy
    elsif self.quantity > 0
      Rails.logger.info "Product quantity is beyond 0: #{self.quantity}"
    end
    # if self.quantity < 5
      # ProductMailer.with(product: self).low_stock_email.deliver_now
    # end
    if self.quantity.nil?
      self.quantity = 1
    end
  end
end
