class AddTranslatedToGames < ActiveRecord::Migration
  def change
  	add_column :games, :translated, :boolean, default: false
  end
end
