class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: [:show]

    def index
        users = User.order(:fullname)
        render json: users
    end

    def show
        render json: @user
    end

    def create
        @user = User.new(create_user_params)

        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def create_user_params
        params.require(:user).permit(:fullname, :surname, :email,
                                    :password, :password_confirmation)
    end
end