class ResetToken < ActiveRecord::Base
  # Use belongs_to because the user_id is on the reset_tokens table.
  belongs_to :user
  
  def self.generate
    value = nil
    loop do
      # Create a random value
      value = (rand * 1000000000).round.to_s(16)
      # Find an existing reset token that has the same value (bad thing)
      rt = ResetToken.find_by_value(value)
      # Quit, unless we found an existing token, in which case we have to try
      # again to create the value
      break unless rt
    end
    expiration = Date.today + 3
    # This is where we actually generate the new token. Since it is the
    # last statement of the method, it will be returned.
    ResetToken.create({value: value, expiration_date: expiration})
  end
  
  def is_valid?
    Date.today < self.expiration_date
  end
  
  
  # Examples of instance methods versus class methods.
  # t = get_reset_token()
  # t.is_valid?
  
  # ResetToken.generate()
  # User.find()
end