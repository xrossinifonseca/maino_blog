

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
      render json: {error:e.message}, status: :unprocessable_entity
    end
  end


  def logout
    cookies.delete(:auth_session)
    cookies.delete(:check_session)
    render json: { message: "Successful logout" }, status: :ok
  end


  private

  def set_cookies(token)
    cookies.signed[:auth_session] = {
        value: token,
        httponly: true,
        secure: true,
        same_site: "none"
      }
      cookies.signed[:check_session] = {
        value: "is authenticated",
        secure: true,
        same_site: "none"
      }
  end


   def set_authentication_cookie(id)
    payload = {customer_id:id}
    token = generate_token(payload)
    set_cookies(token)
  end


  def session_params
    params.permit(:email,:password)
  end

end
