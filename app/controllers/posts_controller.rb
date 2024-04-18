class PostsController < ApplicationController

  include JwtAuthentication


  before_action :authenticate_customer, only: [:create,:update, :destroy]


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



  def update
    begin
      Post.transaction do
        post = Post.find(params["id"])
        post.update!(post_params)
        render json: { message: "Post successfully updated", post:post }, status: :ok
      end

    rescue ActiveRecord::RecordNotFound
      render json: { error: "Post not found" }, status: :not_found
    rescue ActiveRecord::RecordInvalid => e
      render json: {error:e.message}, status: :unprocessable_entity
    rescue => e
      render json: {error:e.message}, status: :unprocessable_entity
    end
  end


  def destroy
    begin
      Post.transaction do
        post = Post.find(params["id"])
        post.destroy
        render json: { message: "Post successfully deleted" }, status: :ok
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Post not found" }, status: :not_found
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
    params.require(:post).permit(:title, :content)
  end
end
