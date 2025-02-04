class CartsController < ApplicationController
    before_action :authenticate_user!

    def show
        @cart = current_user.cart
        # @products = @cart.shopping_carts
        @cart_products = @cart.products
    end
    def create
        if current_user.cart.nil?
            @cart = Cart.new
            @cart.user = current_user
            @cart.save
        else
            @cart = current_user.cart
        end
        product = Product.find(params[:product_id])
        if product.quantity < params[:quantity].to_i
            redirect_to products_path, alert: 'Insufficient quantity in stock.'
            return
        end
        
        @cart.add_product(product)

        if @cart.save
            redirect_to root_url, notice: 'Product added to cart successfully.'
        else
            redirect_to products_path, alert: 'Unable to add product to cart.'
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
    private 





end
