

class SessionController < ApplicationController

  include Authenticator


  def login

    email = session_params[:email]
    password = session_params[:password]
    login_service = CustomerLoginService.new(email,password)

    begin
      customer = login_service.login_validation
      set_authentication_cookie(customer.id)
      render json: {message:"successful login", customer:customer.as_json(except: :password_digest)}

    rescue => e
      render json: {error:e.message}, status: :bad_request
    end
  end




  private

  def session_params

    params.permit(:email,:password)

  end

end
