class User < ActiveRecord::Base
  has_many :links
  validates :email, presence: true
  validates :username, presence: true
  has_secure_password
end