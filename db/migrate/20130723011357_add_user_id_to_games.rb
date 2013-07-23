class AddUserIdToGames < ActiveRecord::Migration
  def change
  	add_column :games, :user_id, :integer
  end
end
