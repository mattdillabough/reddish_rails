class Link < ActiveRecord::Base
  has_many :votes
  has_many :users, through: :votes 
  
  RE_URL = /\Ahttps?:\/\//

  # The links table in the database has a user_id column which records
  # the id of the user who "owns"/created the link.
  belongs_to :user
  belongs_to :category
  
  validates :url, presence: true, format: {with: RE_URL, message: "must start with http(s)://"}
  validates :title, presence: true
  
  def upvote(user)
    existing = self.votes.where(user_id: user.id)
    if existing.size == 0
      return self.votes.create(user_id: user.id, upvote: true, downvote: false) != nil
    else
      return false
    end
  end
end