class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: [:show]

    def index
        users = User.order(:fullname)
        render json: users
    end

    def show
        render json: @user
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end