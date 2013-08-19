class AddTimestampsToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.timestamps
    end
  end
end