

module Posts


  class AddTagsPostService

    def initialize(post)
      @post = post
    end



    def add_tags(tags)

      return unless tags.present?

      tags_array = tags.split(",").map(&:strip)
      tags_array.each do |tag_name|
        check_tag = Tag.find_or_create_by(name: tag_name)
        @post.tags << check_tag unless @post.tags.include?(check_tag)
      end
    end

  end


end
