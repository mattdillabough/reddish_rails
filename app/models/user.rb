class User < ActiveRecord::Base
  has_many :links
  validates :email, presence: true
  validates :username, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end