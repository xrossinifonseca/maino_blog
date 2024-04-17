class ApplicationController < ActionController::API

  include ActionController::Cookies


  protected
   def set_authentication_cookie(id)
    payload = {customer_id:id}
    token = generate_token(payload)
    set_cookies(token)
  end



  private
  def set_cookies(token)
    cookies.signed[:auth_session] = {
        value: token,
        httponly: true,
        secure: true,
        same_site: :strict
      }

      cookies.signed[:check_session] = {
        value: "is authenticated",
        secure: true,
        same_site: :strict
      }
  end

  def generate_token(payload)
    JWT.encode(payload, ENV["JWT_KEY"], 'HS256')
  end

  def decode_token(token)
    JWT.decode(token, ENV["JWT_KEY"], true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end

end
