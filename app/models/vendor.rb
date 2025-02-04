class Vendor < ApplicationRecord
  belongs_to :user
  before_save :set_default_commission_rate
  has_many :products
  def set_default_commission_rate
    self.commission_rate ||= 5 if self.commission_rate.nil?
    # self.vendor  = Vendor.find_by_id(self.
  end
end
