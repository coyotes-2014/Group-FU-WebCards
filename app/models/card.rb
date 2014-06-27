class Card < ActiveRecord::Base
	validates_presence_of :definition, :term, :deck_id 
	validates :answered, inclusion: {in: [true, false]}
  belongs_to :deck, dependent: :destroy
end