class Post < ApplicationRecord
  belongs_to :author, class_name: "Customer", foreign_key: "author_id"
  has_many :comments, dependent: :destroy


  validates :title, presence: { message: "required" }
  validates :content,  presence: { message: "required" }



end
