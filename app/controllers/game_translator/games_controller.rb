class GameTranslator::GamesController < ApplicationController
  load_and_authorize_resource

  def index
    @games = GameTranslator::Game.all
  end

  def edit_multiple
    @games = GameTranslator::Game.not_translated.random.take(4)
  end

  def update_multiple
    I18n.locale = params[:locale]
    params['game'].keys.each do |id|
      @game = GameTranslator::Game.find(id.to_i)
      p '/'*150
      p I18n.locale
      if @game.update_attributes(params['game'][id])
        flash[:sucess] = 'Game traduzido com sucesso!'
      else
        redirect_to game_edit_multiple_path
      end
    end
    redirect_to game_edit_multiple_path
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