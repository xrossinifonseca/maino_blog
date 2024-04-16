require 'rails_helper'

RSpec.describe Customer, :type => :model do

  # let(:customer) {Customer.new}


  it "is valid with valid attributes" do
    customer = Customer.new({name:"Test Name",email:"test@example.com",password:"teste_teste"})
    expect(customer).to be_valid
  end

  it "is not valid without some fild empty" do
    customer = Customer.new({name:"teste",email:"",password:""})
      expect(customer).not_to be_valid
  end

end
