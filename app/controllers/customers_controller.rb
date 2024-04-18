class CustomersController < ApplicationController

  def create
    begin
        @customer = Customer.create!(customer_params)
        render json: {message:"User registered successfully", customer: @customer.as_json(except: :password_digest)}, status: :created
     rescue ActiveRecord::RecordInvalid => e
      render json: {error:e.message}, status: :unprocessable_entity
     rescue => e
      p e
      render json: {error:"there was an internal failure"}, status: :internal_server_error
    end
  end



  def update_password
      begin
          @customer = authenticated_customer
          if @customer.nil?
            return
          end

      new_password = params["new_password"]

      unless new_password
        return render json: { error: "New password is missing" }, status: :unprocessable_entity
      end

      @customer.password = new_password

      if @customer.save!
        render json: { message: "Password changed successfully" }, status: :ok
      else
        render json: { error: @customer.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end

      rescue => e
        render json: { error: e.message }, status: :internal_server_error
      end

  end


  private
  def customer_params
    params.permit(:name,:email,:password)
  end

end
