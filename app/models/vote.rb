class Vote < ActiveRecord::Base
  belongs_to :links
  belongs_to :users
end