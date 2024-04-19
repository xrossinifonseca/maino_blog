class ApplicationController < ActionController::API

  include ActionController::Cookies
  include JwtManager
  include JwtAuthentication



  def route_not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  protected
  def authenticated_customer
    is_auth = authenticate(cookies)
    if is_auth
        Customer.find(is_auth["customer_id"])
    end
  end
end
