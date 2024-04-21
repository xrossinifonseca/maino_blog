
module Posts

  class UploadContentService

    def self.read(file)
      return unless file.present?

        #   verify_type = file.content_type
        #  p verify_type.split("/")

        file_content = file.read
        cleaned_content = file_content.gsub(/[^a-zA-Z\s]/, '')
        content = cleaned_content.split.join(" ")
    end
  end
end
