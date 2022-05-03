require 'bcrypt'
class User < ApplicationRecord
  has_secure_password
  validates :email,
    :presence => {message: "can't be blank"},
    :uniqueness => true
  validates :password_digest,
    :presence => {message: "can't be blank"}


  before_create :make_key
#comment
  private
  def make_key
    self.api_key = SecureRandom.hex(10)
  end
end
