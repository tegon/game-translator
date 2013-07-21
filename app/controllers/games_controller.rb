class GamesController < ApplicationController
	def edit
		@game = ClickJogos::Game.find(params[:id])
	end
	
	def update
		p '-------------------------------------------------'
		p params[:name_en]
	end
end
