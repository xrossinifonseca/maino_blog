class Customer < ApplicationRecord
  has_secure_password
  has_many :posts, foreign_key: "author_id", dependent: :destroy
  before_validation :downcase_fields


  validates :name, presence: { message: "Name required" }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: { message: "Password required" }, length: { minimum: 6, message: "Password must be at least 6 characters long" }


  def downcase_fields
    self.name = name.downcase if name.present?
    self.email = email.downcase if email.present?
  end

end
