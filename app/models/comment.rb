class Comment < ApplicationRecord
  belongs_to :post
  validates :content, presence: true

  before_save :assign_default_author_name


  def assign_default_author_name
    self.author_name = "anonymous" if author_name.blank?
  end

end
