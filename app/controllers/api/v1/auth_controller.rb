class Api::V1::AuthController < ApplicationController

  def login
    auth_token = Api::V1::Auth::AuthenticateUser.new(login_params[:email], login_params[:password]).call
    
    json_response(auth_token: auth_token)
  end

  def register
    user = User.create!(register_params)

    auth_token = Api::V1::Auth::AuthenticateUser.new(user.email, user.password).call

    response = { message: Message.account_created, auth_token: auth_token }

    json_response(response, :created)
  end

  private

  def login_params
    params.permit(
      :email,
      :password
    )
  end

  def register_params
    params.permit(
      :fullname, 
      :surname, 
      :email, 
      :password, 
      :password_confirmation
    )
  end
end