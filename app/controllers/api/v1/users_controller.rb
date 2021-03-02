class Api::V1::UsersController < ApplicationController

    def index
        users = User.order(:fullname)
        render json: users
    end
end