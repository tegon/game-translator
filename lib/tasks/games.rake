namespace :games do

	desc "Importer CJ Games"
	task :import => :environment do 
		ClickJogos::Game.all.map do |game|
			g = GameTranslator::Game.new
			g.cj_id = game.id
			g.short_description = game.short_description
			g.long_description = game.long_description
			g.wide_description = game.wide_description
			g.instructions = game.instructions
			g.name = game.name
			g.save
			puts "Game #{ game.id } importado!"
		end
	end

	desc "Export CJ Games" 
	task :export => :environment do
		GameTranslator::Game.all.map do |game|
			g = ClickJogos::Game.where(id: game.cj_id)
			g.update_attributes(game)
			puts "Game #{ g.id } exportado!"
		end
	end
end