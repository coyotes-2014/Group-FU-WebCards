require 'bcrypt'

class User < ActiveRecord::Base
	validates_presence_of :name, :email, :password_hash
  validates_uniqueness_of :email
  has_many :user_decks, dependent: :destroy
  has_many :decks, through: :user_decks

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
