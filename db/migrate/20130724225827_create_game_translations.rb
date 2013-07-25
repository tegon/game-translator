class CreateGameTranslations < ActiveRecord::Migration
	def up
	  GameTranslator::Game.create_translation_table!({
	    name: :string,
	    short_description: :string,
	    long_description: :text,
	    wide_description: :text,
	    instructions: :text
	  }, {
	    migrate_data: true
	  })
	end

	def down
	  GameTranslator::Game.drop_translation_table! migrate_data: true
	end
end
