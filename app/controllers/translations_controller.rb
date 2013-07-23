class TranslationsController < ApplicationController
	def new	
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