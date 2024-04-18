class CommentsController < ApplicationController



  def create

    begin
    post = Post.find(params["id"])
    comment = post.comments.create!(comment_params)
    render json: {message:"comment added", comment:comment}

   rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not found" }, status: :not_found
   rescue ActiveRecord::RecordInvalid => e
    render json: {error:e.message}, status: :unprocessable_entity
    rescue => e
    render json: {error:e.message}, status: :unprocessable_entity
  end
end



  def comment_params
    params.require(:comment).permit(:content,:author_name)
  end
end
