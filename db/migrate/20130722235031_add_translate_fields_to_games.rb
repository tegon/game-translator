class AddTranslateFieldsToGames < ActiveRecord::Migration
  def change
  	add_column :games, :short_description_en, :string
  	add_column :games, :long_description_en, :text
  	add_column :games, :wide_description_en, :text
  	add_column :games, :instructions_en, :text
  	add_column :games, :name_en, :string
  end
end
