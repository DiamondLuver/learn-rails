class User < ApplicationRecord
  has_one :cart
  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # enum role: [:user, :moderator, :admin]

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
  
end
