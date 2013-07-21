class GamesController < ApplicationController
	def edit
		@game = ClickJogos::Game.find(params[:id])
	end
end