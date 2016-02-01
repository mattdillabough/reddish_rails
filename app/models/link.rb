class Link < ActiveRecord::Base
  has_many :votes
  has_many :users, through: :votes 
  
  RE_URL = /\Ahttps?:\/\//

  # The links table in the database has a user_id column which records
  # the id of the user who "owns"/created the link.
  # belongs_to :owner, class_name: 'User', foreign_key: "user_id"
  belongs_to :user
  belongs_to :category
  
  validates :url, presence: true, format: {with: RE_URL, message: "must start with http(s)://"}
  validates :title, presence: true
    
  def upvote(user)
    generic_vote(:upvote, user)
  end
  
  def downvote(user)
    generic_vote(:downvote, user)
  end
  
  def upvoted_by?(user)
    generic_voted_by?(:upvote, user)
  end
  
  def downvoted_by?(user)
    generic_voted_by?(:downvote, user)
  end
  
  private
  
  def generic_voted_by?(direction, user)
    return nil if !user
    vote = self.votes.find_by_user_id(user.id)
    return !vote.nil? && vote.send(direction)
  end
  
  # :upvote or :downvote
  def generic_vote(direction, user)
    existing = self.votes.find_by_user_id(user.id)
    self.users.destroy(user) if !existing.nil?
    if existing.nil? || !existing.send(direction)
      vote = self.votes.create(
        user_id: user.id, upvote: direction == :upvote, downvote: direction == :downvote)
      return vote != nil
    end     
  end
end