class GamesController < ApplicationController
	def edit
		@game = ClickJogos::Game.find(params[:id])
	end
	
	def update
		p '-------------------------------------------------'
		p params[:name_en]
	end

	def edit_multiple
	  @games = ClickJogos::Game.find(params[:game_ids])
	end

	def update_multiple
	  @games = ClickJogos::Game.find(params[:game_ids])
	  @games.each do |game|
	    game.update_attributes!(params[:game].reject { |k,v| v.blank? })
	  end
	  flash[:notice] = "Updated games!"
	  redirect_to games_path
	end

	def index
		@games = ClickJogos::Game.not_translated.random.take(4)
		p '------------------------------------------------------'
		p @games
	end
end