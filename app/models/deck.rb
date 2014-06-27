class Deck < ActiveRecord::Base
	validates_presence_of :name
  has_many :user_decks, dependent: :destroy
  has_many :cards
  has_many :users, through: :user_decks
end