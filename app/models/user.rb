class User < ActiveRecord::Base
	validates_presence_of :name, :email, :password_hash
  validates_uniqueness_of :email
  has_many :user_decks, dependent: :destroy
  has_many :decks, through: :user_decks
end