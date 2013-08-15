class RemoveRejectedFromGameTranslations < ActiveRecord::Migration
  def change
    remove_column :game_translations, :rejected
  end
end
