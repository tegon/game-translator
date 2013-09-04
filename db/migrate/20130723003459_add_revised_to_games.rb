class AddRevisedToGames < ActiveRecord::Migration
  def change
  	add_column :games, :revised, :integer, default: 0
  end
end
