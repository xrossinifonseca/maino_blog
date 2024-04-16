

module Authenticator

class CustomerLoginService

  def initialize(email,password)
    @email = email
    @password = password
  end


  def login_validation
   customer = checkCredential
  raise AuthenticationError.new("invalid credentials") unless customer
   customer
  end



  private

  def checkCredential
     return false if @email.blank? || @password.blank?

     customer = Customer.find_by(email:@email)

     return false unless customer && customer.authenticate(@password)

     customer
  end

end


class AuthenticationError < StandardError; end

end
