class UserDeck < ActiveRecord::Base
	validates_presence_of :results
  belongs_to :user
  belongs_to :deck
end
