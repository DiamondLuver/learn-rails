class ProductsController < ApplicationController
    before_action :authenticate_user! , only: [:create, :destroy]
    before_action :set_product,:admin_only, only: [:edit, :update, :destroy]

    def index
        @products = Product.all
        if user_signed_in?
            if current_user.has_role?(:admin)
                render template: 'admin/index' 
            end
        end
    end
    
    def show
        @product = Product.find(params[:id])
    end

    def new
        @product = Product.new
    end
    
    def create
        @product = Product.new(product_params)
        @vendor = Vendor.find_by(user: current_user)
        @product.vendor = @vendor
        @product.save
        if @product.save
            flash[:notice] = "Product was successfully created."
            redirect_to @product
        else
            flash.now[:alert] = "There was an error creating the product."
            render :new
        end
    end

    def edit
    end

    def update
        if @product.update(product_params)
           redirect_to products_url, notice: 'Product was successfully updated.'
        else
           render :edit
        end
    end
    
    def destroy
        if @product.destroy
            redirect_to products_url, notice: 'Product was successfully destroyed.'
        else
            redirect_to products_url, alert: 'Failed to delete the Product.'
        end
    end

    private
    def set_product
        @product = Product.find(params[:id])
    end
    def product_params
        params.require(:product).permit(:name, :description,:quantity, :price)
    end

    def user_signed_in?
        !current_user.nil?
    end
    def admin_only
        unless current_user.has_role?(:admin)
            redirect_to root_path, :alert => "Access denied."
        end
    end
end
