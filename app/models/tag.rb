class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags
  before_validation :downcase_fields



  def downcase_fields
    self.name = name.downcase if name.present?
  end

end
