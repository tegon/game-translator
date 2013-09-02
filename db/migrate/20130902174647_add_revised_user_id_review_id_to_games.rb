class AddRevisedUserIdReviewIdToGames < ActiveRecord::Migration
  def change
    remove_column :game_translations, :user_id
    remove_column :game_translations, :review_id
    remove_column :game_translations, :revised

    change_table :games do |t|
      t.belongs_to :user
      t.belongs_to :review
      t.boolean :revised, default: false
    end
  end
end
