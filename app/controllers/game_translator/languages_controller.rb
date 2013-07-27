class GameTranslator::LanguagesController < ApplicationController
  load_and_authorize_resource

  def index
    @languages = GameTranslator::Language.all
  end

  def new
    @language = GameTranslator::Language.new
  end

  def create
    @language = GameTranslator::Language.create(params[:game_translator_language])
    if @language.save
      flash[:success] = 'Cadastrado com sucesso!'
      redirect_to languages_path
    else
      render action: :new
    end
  end

  def edit
    @language = GameTranslator::Language.find(params[:id])
  end

  def update
    @language = GameTranslator::Language.find(params[:id])
    if @language.update_attributes(params[:game_translator_language])
      flash[:sucess] = 'Game traduzido com sucesso!'
      redirect_to languages_path
    else
      render action: :edit
    end
  end

  def destroy
    language = GameTranslator::Language.find(params[:id])
    if language.destroy
      flash[:sucess] = 'Cadastro deletado!'
      redirect_to languages_path
    else
      render action: :edit
    end
  end
end