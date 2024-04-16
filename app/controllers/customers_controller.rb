class CustomersController < ApplicationController




  def create
    begin
      Customer.transaction do
        @customer = Customer.create!(customer_params)
        render json: {message:"User registered successfully", customer: @customer.as_json(except: :password_digest)}, status: :created
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: {error:e.message}, status: :unprocessable_entity
    rescue => e
      p e
      render json: {error:"there was an internal failure"}, status: :internal_server_error
    end
  end

  private

  def customer_params
    params.permit(:name,:email,:password)
  end

end
