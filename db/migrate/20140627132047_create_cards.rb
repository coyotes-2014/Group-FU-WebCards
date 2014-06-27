class CreateCards < ActiveRecord::Migration
  def change
   	create_table :cards do |t|
  		t.text :definition, null: false
  		t.string :term, null: false
  		t.integer :deck_id, null: false
  		t.string :answered, default: false
  		t.timestamps
  	end
  end
end
