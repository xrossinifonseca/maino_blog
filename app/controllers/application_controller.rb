class ApplicationController < ActionController::API

  include ActionController::Cookies
  include JwtManager
  include JwtAuthentication



  protected
  def authenticated_customer
    is_auth = authenticate(cookies)
    if is_auth
        Customer.find(is_auth["customer_id"])
    end
  end
end
