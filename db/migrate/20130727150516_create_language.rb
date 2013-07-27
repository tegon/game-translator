class CreateLanguage < ActiveRecord::Migration
  def change
  	create_table :languages do |t|
  		t.string :abbreviation
  		t.string :name
  		t.timestamps
  	end
  end
end
