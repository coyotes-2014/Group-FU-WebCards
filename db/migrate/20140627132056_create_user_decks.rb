class CreateUserDecks < ActiveRecord::Migration
  def change
  	create_table :user_decks do |t|
  		t.integer :user_id, null: false
  		t.integer :deck_id, null: false
  		t.decimal :results, default: 0
      t.integer :total_guesses, default: 0
      t.integer :total_incorrect, default: 0
      t.integer :total_correct, default: 0
  		t.timestamps
  	end
  end
end
