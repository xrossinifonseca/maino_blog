require 'rails_helper'

RSpec.describe Customer, :type => :model do


  before do
    @customer = Customer.create!(name: "Test Customer", email: "test@example.com",password:"testepassword")
  end


  it "should create with valid inputs" do


    post = Post.new(
      title: "title test",
      content: "content test",
      author_id: @customer.id)

      expect(post).to be_valid
  end

  it "is not valid without some fild empty" do
    post = Post.new(
      title: "",
      content: "content test",
      author_id: @customer.id)

      expect(post).not_to be_valid
  end

end
