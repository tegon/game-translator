class CreateTranslators < ActiveRecord::Migration
  def change
    create_table :translators do |t|

      t.timestamps
    end
  end
end
