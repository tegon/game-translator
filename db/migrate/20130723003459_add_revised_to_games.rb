class AddRevisedToGames < ActiveRecord::Migration
  def change
  	add_column :games, :revised, :integer, default: false
  end
end
