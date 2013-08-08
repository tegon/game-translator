class AddReviewIdToTranslations < ActiveRecord::Migration
  def change
    add_column :game_translations, :review_id, :integer
  end
end
