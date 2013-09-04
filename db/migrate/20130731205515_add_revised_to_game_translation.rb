class AddRevisedToGameTranslation < ActiveRecord::Migration
  def change
    remove_column :games, :revised

    add_column :game_translations, :revised, :boolean, default: 0

    change_column :games, :translated, :boolean, default: 0
  end
end
