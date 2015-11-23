class RemoveVotesFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :upvotes
    remove_column :links, :downvotes
  end
end
