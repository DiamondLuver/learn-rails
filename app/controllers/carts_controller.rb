class CartsController < ApplicationController
    before_action :authenticate_user!

    def show
        @cart = current_user.cart
        @shopping_carts = @cart.get_shopping_carts
        @cart_products = @cart.products
        @quantities = @shopping_carts.group(:product_id).sum(:quantity)
        if @cart_products.empty?
            @total_price = 0
        else
            @total_price = @cart_products.sum { |product| @quantities[product.id] * product.price }
        end
    end

    def create
        if current_user.cart.nil?
            @cart = Cart.new
            @cart.user = current_user
            @cart.save
        else
            @cart = current_user.cart
        end
        @shopping_carts = @cart.shopping_carts
        
        product = Product.find(params[:product_id])
        if product.quantity < params[:quantity].to_i
            redirect_to products_path, alert: 'Insufficient quantity in stock.'
            return
        end
        if @cart.add_product(product, params[:quantity].to_i)
            redirect_to root_url, notice: 'Product added to cart successfully.'
        else
            redirect_to root_url, alert: 'Total quantity exceed stock in cart.'
        end
        
    end
    def remove_from_cart
        product = Product.find(params[:product_id])
        @cart = current_user.cart
        @cart.remove_product(product)
        if @cart.save
            redirect_to cart_path, notice: 'Product removed from cart successfully.'
        end
    end
    def checkout
        @cart = current_user.cart
        if @cart.checkout_order
            redirect_to payment_checkout_path, notice: 'Order placed successfully.'
        end
    end
end
