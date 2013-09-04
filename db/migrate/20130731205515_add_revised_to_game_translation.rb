class AddRevisedToGameTranslation < ActiveRecord::Migration
  def change
    remove_column :games, :revised

    add_column :game_translations, :revised, :boolean, default: false

    change_column :games, :translated, :boolean, default: false
  end
end
