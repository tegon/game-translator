class AddUserIdToGameTranslations < ActiveRecord::Migration
  def up
    remove_column :games, :user_id

    add_column :game_translations, :user_id, :integer
  end

  def down
    remove_column :game_translations, :user_id

    add_column :games, :user_id
  end
end
