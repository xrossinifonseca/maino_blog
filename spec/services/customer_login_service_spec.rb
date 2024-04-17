require 'rails_helper'


RSpec.describe Authenticator::CustomerLoginService do

  before(:each) do
    @customer = Customer.create!(name: "test", email: "test@example.com", password: "testpassword")
  end

  it "must log in and return customer data" do
    logged_in_customer  = Authenticator::CustomerLoginService.new("test@example.com", "testpassword").login_validation
    expect(logged_in_customer).to eq(@customer)
  end

  it "must raise arr error if its the wrong credentials" do
    expect { Authenticator::CustomerLoginService.new("test@example.com", "wrongpassword").login_validation }.to raise_error("invalid credentials")
  end


end
