class Post < ApplicationRecord
  belongs_to :author, class_name: "Customer", foreign_key: "author_id"

  validates :title, presence: { message: "required" }
  validates :content,  presence: { message: "required" }



end
