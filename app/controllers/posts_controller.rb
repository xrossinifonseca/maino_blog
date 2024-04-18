class PostsController < ApplicationController

  include JwtAuthentication


  def create

    begin
      @customer = authenticated_customer
      if @customer.nil?
        return
      end

      Post.transaction do
        post = Post.create!(post_params.merge(author_id: @customer.id))
        render json: {message:"Post created successfully", post: post }, status: :created
      end

    rescue ActiveRecord::RecordInvalid => e
      render json: {error:e.message}, status: :unprocessable_entity
    rescue => e
      p e
      render json: {error:"there was an internal failure"}, status: :internal_server_error
    end

  end


  private
  def post_params
    params.permit(:title,:content)
  end
end
