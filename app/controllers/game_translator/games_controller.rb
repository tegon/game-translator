class GameTranslator::GamesController < ApplicationController
  def index
    @games = GameTranslator::Game.all
  end

  def new
    @game = GameTranslator::Game.new
  end

  def edit
    @game = GameTranslator::Game.find(params[:id])
    p 'edit-'*150
    p I18n.locale
  end

  def update
    I18n.locale = params[:locale]
    @game = GameTranslator::Game.find(params[:id])
    if @game.update_attributes(params[:game_translator_game])
      p 'update/'*150
      p I18n.locale
      flash[:sucess] = 'Cadastro atualizado com sucesso!'
      p 'update/'*150
      p I18n.locale
      redirect_to game_edit_path, id: @game.id
    else
      render action: :edit, id: @game.id
    end
  end

  def create
    @game = GameTranslator::Game.new(params[:game_translator_game])
    if @game.save
      flash[:success] = 'Cadastrado com sucesso!'
      redirect_to game_index_path
    else
      render action: 'new'
    end
  end

  def destroy
    game = GameTranslator::Game.find(params[:id])
    if game.destroy
      flash[:sucess] = 'Cadastro deletado!'
      redirect_to game_index_path
    else
      render action: :edit
    end
  end
end