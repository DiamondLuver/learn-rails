class VendorsController < ApplicationController
    before_action :authenticate_user!, :admin_only
    before_action :set_vendor, only: [:show, :edit, :update, :destroy]

    def index
        @vendors = Vendor.all
    end
    
    def show

    end

    def new
        @vendor = Vendor.new
        @users = User.all
    end
    
    def create
        @vendor = Vendor.new(vendor_params)
        if params[:user_id].present?
            @vendor.user = User.find(params[:user_id])
        else
            @vendor.user = current_user
        end

        if @vendor.save
            flash[:notice] = "Vendor was successfully created."
            redirect_to @vendor
        else
            flash.now[:alert] = "There was an error creating the vendor."
            render :new
        end
    end

    def edit
    end

    def update
        if @vendor.update(vendor_params)
           redirect_to vendors_url, notice: 'vendor was successfully updated.'
        else
           render :edit
        end
    end
    
    def destroy
        @vendor.update(user: nil)
        if @vendor.destroy
            redirect_to vendors_url, notice: 'vendor was successfully destroyed.'
        else
            redirect_to vendors_url, alert: 'Failed to delete the vendor.'
        end
    end

    private
    def set_vendor
        @vendor = Vendor.find(params[:id])
    end
    def vendor_params
        params.require(:vendor).permit(:name, :description, :user_id)
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
