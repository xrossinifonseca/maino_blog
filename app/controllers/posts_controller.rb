class PostsController < ApplicationController

  include JwtAuthentication


  before_action :authenticate_customer, only: [:create, :destroy]


  def create
    begin
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


  def destroy
    begin
      Post.transaction do
        post = Post.find(params["id"])
        post.destroy
        render json: { message: "Post successfully deleted" }, status: :ok
      end

    rescue ActiveRecord::RecordInvalid => e
      render json: {error:e.message}, status: :unprocessable_entity
    rescue => e
      render json: {error:e.message}, status: :unprocessable_entity
    end
  end




  private
  def authenticate_customer
    @customer = authenticated_customer
    if @customer.nil?
      return
    end
  end

  def post_params
    params.permit(:title,:content)
  end
end
