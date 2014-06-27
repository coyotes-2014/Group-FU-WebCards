class UserDeck < ActiveRecord::Base
	validates_presence_of :user_result
  belongs_to :user
  belongs_to :deck
end