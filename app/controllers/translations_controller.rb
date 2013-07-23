class TranslationsController < ApplicationController
  before_filter :authenticate_user!

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
    @game = GameTranslator::Game.where(cj_id: params[:id])

    if @game.update_attributes()
      flash[:success] = 'Jogo atualizado!'
      redirect_to 
    else
      render action: 'edit'
    end
  end
end