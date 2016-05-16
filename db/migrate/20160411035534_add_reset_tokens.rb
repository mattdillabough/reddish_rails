class AddResetTokens < ActiveRecord::Migration
  def change
    create_table :reset_tokens do |t|
      t.string :value
      t.timestamp :expiration_date
      t.integer :user_id
    end
  end
end
