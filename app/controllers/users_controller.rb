class UsersController < ApplicationController
    before_action :authenticate_user!, :check_admin
    before_action :set_user, only: [:show, :update, :destroy]

    def index
        @users = User.all
    end

    def show
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "User was successfully created."
            redirect_to @user
        else
            flash.now[:alert] = "There was an error creating the user."
            render :new
        end
    end
    def update
        if @user.update(user_params)
            flash[:notice] = "User was successfully updated."
            redirect_to @user
        else
            flash.now[:alert] = "There was an error updating the user."
            render :edit
        end
    end
    def destroy
        @user.destroy
        flash[:notice] = "User was successfully deleted."
        redirect_to users_path
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def set_user
        @user = User.find(params[:id])
    end
    def check_admin
        unless current_user.has_role?(:admin)
            redirect_to root_path, alert: "You are not authorized to perform this action."
        end
    end
end
