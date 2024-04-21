class PostsController < ApplicationController

  include JwtAuthentication


  before_action :authenticate_customer, only: [:create,:update, :destroy,:customer_posts]

  def index
    begin
      posts = Posts::PostsTagQueryService.fetch_posts(params["tags"]).page(params["page"]).per(3)

      if posts.present? && posts.length > 0
        posts_with_authors_name =  posts.map do |t|
        {id:t.id,title:t.title,author:t.author.name,tags:t.tags.map(&:name),date:t.created_at}
        end
      else
        posts_with_authors_name = []
      end

      total_pages = posts.total_pages
      render json: { posts: posts_with_authors_name, total_pages: total_pages }, status: :ok

    rescue ActiveRecord::RecordNotFound
      render json: { error: "Posts not found" }, status: :not_found
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end


  def show
    begin
    post = Post.find(params[:id])
    post_data = {
    id: post.id,
    title: post.title,
    content: post.content,
    author: post.author.name,
    author_id:post.author.id,
    tags: post.tags.map(&:name),
    comments: post.comments}

   render json: post_data, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Posts not found" }, status: :not_found
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  end

  def create
    begin
      Post.transaction do

        post = Post.create!(post_params.merge(author_id: @customer.id))
        Posts::AddTagsPostService.new(post).add_tags(params["tags"])
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


        if does_post_belongs_customer?(post)
          post.update!(post_params)
          render json: { message: "Post successfully updated", post:post }, status: :ok
        else
          render json: { error: "You are not authorized to update this post" }, status: :forbidden
        end
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

        if does_post_belongs_customer?(post)
          PostTag.where(post_id: post.id).destroy_all
          post.destroy
          render json: { message: "Post successfully deleted" }, status: :ok
        else
          render json: { error: "You are not authorized to delete this post" }, status: :forbidden
        end
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Post not found" }, status: :not_found
    rescue ActiveRecord::RecordInvalid => e
      render json: {error:e.message}, status: :unprocessable_entity
    rescue => e
      render json: {error:e.message}, status: :unprocessable_entity
    end
  end


  def upload_content
    file_upload = params["upload"]
    content = Posts::UploadContentService.read(file_upload)

    if content
      render json: {message:"content found successfully",content:content}, status: :ok
    else
      render json: {message:"undetected text",content:content}, status: :unprocessable_entity
    end
  end


  def customer_posts
    begin

        posts = @customer.posts.page(params["page"]).per(3)

      if posts.length > 0
        posts_data =  posts.map do |t|
        {id:t.id,title:t.title,author:t.author.name,tags:t.tags.map(&:name),date:t.created_at}
        end
      else
        posts_data = []
      end

      total_pages = posts.total_pages
      render json: { posts: posts_data, total_pages: total_pages }, status: :ok

    rescue ActiveRecord::RecordInvalid => e
      render json: {error:e.message}, status: :unprocessable_entity
    rescue => e
      p e
      render json: {error:"there was an internal failure"}, status: :internal_server_error
    end

  end



  private
  def authenticate_customer
    @customer = authenticated_customer
    if @customer.nil?
      return
    end
  end


  def does_post_belongs_customer?(post)
     post.author_id == @customer.id
  end


  def post_params
    params.require(:post).permit(:title, :content,:tags)
  end
end
