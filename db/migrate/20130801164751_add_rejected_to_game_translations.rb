class AddRejectedToGameTranslations < ActiveRecord::Migration
  def change
    add_column :game_translations, :rejected, :boolean, default: false
  end
end