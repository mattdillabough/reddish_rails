class AddVotes < ActiveRecord::Migration
  def change
    create_join_table :links, :users, table_name: :votes do |t|
      t.index :link_id
      t.index :user_id
      t.boolean :upvote
      t.boolean :downvote
      t.timestamps
    end
  end
end
