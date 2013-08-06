class AddStatusToGames < ActiveRecord::Migration
  def change
    remove_column :games, :translated

    add_column :games, :status, :string, default: 'not_translated'
  end
end