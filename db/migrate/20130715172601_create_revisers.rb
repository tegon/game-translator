class CreateRevisers < ActiveRecord::Migration
  def change
    create_table :revisers do |t|

      t.timestamps
    end
  end
end
