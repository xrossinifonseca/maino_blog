class PasswordResetsController < ApplicationController
  def new
  end

  def create
    if @customer = Customer.find_by(email:params[:email_address])
      PasswordMailer.with(customer: @customer).reset.deliver_now
      render json: { message: "Email sent with password reset instructions." }, status: :ok
    else
      render json: { error: "Email address not found." }, status: :not_found
    end
  end


  def update


    @Customer = Customer.find_signed!(params[:token], purpose: 'password_reset')

    if @Customer.update(password_params)
     return render json: { message: "password changed successfully" }, status: :ok
    else
      render json: { message: "failed to change password" }, status: :unprocessable_entity
    end

  rescue ActiveSupport::MessageVerifier::InvalidSignature

    render json: { message: "failed to change password" }, status: :unprocessable_entity

  end

  private

  def password_params
    params.permit(:password)
  end


end
