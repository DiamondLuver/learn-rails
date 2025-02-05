# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# user = User.find_or_create_by!(firstname: 'admin', lastname: 'admin', email: 'admin1@mail.com', password: '123456')
user = User.find_by_id(2)
user.add_role :admin
# user = User.find(1)
# Vendor.find_or_create_by!(name: 'Vendor 1', user: user, description: 'Vendor 1 description', status: 1)
vendor = Vendor.find(1)
# Product.find_or_create_by!(name: 'Product 1',vendor: vendor, description: 'Product 1 description', price: 100)

# products = Product.all
# products.each do |product|
#     product.update_attribute(:quantity, 10)
# end


# cart = Cart.find_by_id(1)
# cart.update_attribute(:status, 3)