class PaymentsController < ApplicationController
    def new
    end
    def create_checkout_session
      session = Stripe::Checkout::Session.create({
      line_items: [{
        price: params[:price],
        quantity: params[:quantity],
      }],
      mode: 'payment',
      success_url: ,
      cancel_url: YOUR_DOMAIN + '/cancel.html',
    })
    redirect session.url, 303
    end
    def create
      customer = Stripe::Customer.create({
        :email => params[:stripeEmail],
        :source => params[:stripeToken]
      })
      
      charge = Stripe::Charge.create({
        :customer => customer.id,
        :amount => 500,
        :description => 'Description of your product',
        :currency => 'usd'
      })
    
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_payment_path
    end
    def success
      redirect_to root_url, notice: "Purchase Successful"
    end
    
    def cancel
      redirect_to root_url, notice: "Purchase Unsuccessful"
    end
end
