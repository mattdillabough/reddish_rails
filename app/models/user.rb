class User < ActiveRecord::Base
  RE_USERNAME = /\A[A-Za-z0-9_]+\z/
  
  has_many :links
  validates :email, presence: true
  validates :username, presence: true, length: {minimum: 4, maximum: 20}, format: {with: RE_USERNAME, message: "must contain only letters, digits and underscore"}
  has_secure_password
end