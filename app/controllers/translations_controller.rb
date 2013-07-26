class TranslationsController < ApplicationController
  

	def edit	
    p '/'*150
    p user_session
    p current_user
    p user_signed_in?
		@game = ClickJogos::Game.find(params[:id])
		p '-'*150
		p @game
	end

	def update
    @game = GameTranslator::Game.new
    @game.cj_id = params[:id]
    @game.name_en = params[:name_en]
    @game.short_description_en = params[:short_description_en]
    @game.long_description_en = params[:long_description_en]
    if @game.save
      flash[:success] = 'Jogo traduzido!'
      redirect_to 'translate/'
    else
      render action: 'edit'
    end
  end
end