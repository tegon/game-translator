class AddRejectedToGameTranslations < ActiveRecord::Migration
  def change
    add_column :game_translations, :rejected, :boolean, default: 0
  end
end