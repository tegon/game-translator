class AddIndexesToGameTranslations < ActiveRecord::Migration
  def change
    add_index :game_translations, :user_id
    add_index :game_translations, :review_id
  end
end