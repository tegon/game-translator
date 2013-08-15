class RenameAbbreviationToCode < ActiveRecord::Migration
  def change
    rename_column :languages, :abbreviation, :code
  end
end
