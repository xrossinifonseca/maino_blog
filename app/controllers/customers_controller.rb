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


  def profile

      begin
          @customer = authenticated_customer
          if @customer.nil?
            return
          end

        render json: @customer.as_json(except: :password_digest), status: :ok

      rescue => e
        render json: { error: e.message }, status: :internal_server_error
      end
  end

  def update_password
      begin
          @customer = authenticated_customer
          if @customer.nil?
            return
          end

      new_password = params["new_password"]
      current_password = params["current_password"]

      unless new_password || current_password
        return render json: { error: "New password is missing" }, status: :unprocessable_entity
      end

      if !@customer.authenticate(current_password)
        return render json: { error: "invalid password" }, status: :unprocessable_entity
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


    def update

      begin
        @customer = authenticated_customer
        if @customer.nil?
          return
        end

        @customer.name = params["name"] if params["name"].present?
        @customer.email = params["email"] if params["email"].present?


        if @customer.save(validate: false)
          render json: { message: "Data updated successfully" }, status: :ok
        end

      rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
      rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
    end

  private
  def customer_params
    params.permit(:name,:email,:password)
  end
end
