class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  before_action :authenticate_user!
  def new
    @amount_converted = @amount * 100
  end

  def create
    customer = StripeTool.create_customer(email: params[:stripeEmail], 
                                          stripe_token: params[:stripeToken])
    @amount_converted = @amount * 100
    charge = StripeTool.create_charge(customer_id: customer.id, 
                                      amount: @amount_converted,
                                      description: @description)
    @cart.status = 4
    @cart.save
    redirect_to thanks_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
  def thanks
  end

  private
  def description
    @description = "Some amazing product"
  end
  def amount_to_be_charged
    @cart = current_user.cart
    @shopping_carts = @cart.get_shopping_carts
    @cart_products = @cart.get_products
    @quantities = @shopping_carts.group(:product_id).sum(:quantity)
    @amount = @cart_products.sum { |product| @quantities[product.id] * product.price }
  end
end
