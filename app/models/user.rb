class User < ActiveRecord::Base
  RE_USERNAME = /\A[A-Za-z0-9_.]+\z/
  RE_EMAIL = /\A[A-Za-z0-9_.]+@[A-Za-z0-9_.]+\z/
  
  has_many :links
  validates :email, presence: true, uniqueness:true, format: {with: RE_EMAIL, message: "must be a valid email"}
  validates :username, presence: true, uniqueness: true, length: {minimum: 4, maximum: 20}, format: {with: RE_USERNAME, message: "must contain only letters, digits and underscore"}
  has_secure_password
end