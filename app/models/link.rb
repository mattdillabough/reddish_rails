class Link < ActiveRecord::Base
  RE_URL = /\Ahttps?:\/\//

  # The links table in the database has a user_id column which records
  # the id of the user who "owns"/created the link.
  belongs_to :user
  belongs_to :category
  
  validates :url, presence: true, format: {with: RE_URL, message: "must start with http(s)://"}
  validates :title, presence: true
end