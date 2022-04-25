class User < ApplicationRecord
  validates :email,
    :presence => {message: "can't be blank"},
    :uniqueness => true
  validates :password_digest,
    :presence => {message: "can't be blank"}
  has_secure_password

  before_create :make_key

  private
  def make_key
    self.api_key = SecureRandom.hex(10)
  end
end
