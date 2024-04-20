class Post < ApplicationRecord
  belongs_to :author, class_name: "Customer", foreign_key: "author_id"
  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags


  validates :title, presence: { message: "required" }
  validates :content,  presence: { message: "required" }


end
