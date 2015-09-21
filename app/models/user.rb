class User < ActiveRecord::Base
  RE_USERNAME = /\A[A-Za-z0-9_.]+\z/
  RE_EMAIL = /\A[A-Za-z0-9_.]+@[A-Za-z0-9_.]+\z/
  
  # This association declaration is the inverse of the "belongs_to" on the link.rb
  # It indicates that a given object of type User, let's call him user_a, has a collection
  # of links. So:
  #
  # user_a.links
  #
  # Is valid code. There are lots of methods that get added to the User class by creating
  # a has_many association. Search Google for "Rails has_many methods".
  has_many :links
  
  validates :email, presence: true, uniqueness:true, format: {with: RE_EMAIL, message: "must be a valid email"}
  validates :username, presence: true, uniqueness: true, length: {minimum: 4, maximum: 20}, format: {with: RE_USERNAME, message: "must contain only letters, digits and underscore"}
  has_secure_password
end