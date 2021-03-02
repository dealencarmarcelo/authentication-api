class Api::V1::AuthenticationController < ApplicationController

  def login
    auth_token = Api::V1::Auth::AuthenticateUser.new(login_params[:email], login_params[:password]).call
    
    json_response(auth_token: auth_token)
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end