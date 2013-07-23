class CreateGames < ActiveRecord::Migration
  def up
  	create_table :games do |t|
  		t.integer :id
  		t.string :short_description
  		t.text :long_description
  		t.text :wide_description
  		t.text :instructions
  		t.string :name
      t.integer :cj_id
  	end
  end

  def down
  	drop_table :games
  end
end
