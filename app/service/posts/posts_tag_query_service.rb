
module Posts


  class PostsTagQueryService

    def self.fetch_posts(tags)
      if tags.present?
        tag_names = tags.split(' ')
        p tag_names
        @posts = Post.joins(:tags).where(tags: { name: tag_names }).order(created_at: :desc).distinct
      else
        @posts = Post.order(created_at: :desc)
      end
    end
  end
end
