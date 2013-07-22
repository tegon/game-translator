class TranslationsController < ApplicationController
	def index
		@games = ClickJogos::Game.first(4)
	end
end