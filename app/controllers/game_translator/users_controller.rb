class GameTranslator::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = GameTranslator::User.paginate(page: params[:page])
  end

  def new
    @user = GameTranslator::User.new
  end

  def create
    @user = GameTranslator::User.new(params[:game_translator_user])
    if @user.save
      flash[:success] = 'Cadastrado com sucesso!'
      redirect_to user_index_path
    else
      render action: :new
    end
  end

  def edit
    @user = GameTranslator::User.find(params[:id])
  end

  def update
    @user = GameTranslator::User.find(params[:id])

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(params[:game_translator_user])
    else
      params[:game_translator_user].delete(:current_password)
      @user.update_without_password(params[:game_translator_user])
    end

    if successfully_updated
      flash[:sucess] = 'Cadastro atualizado com sucesso!'
      redirect_to user_index_path
    else
      render action: :edit
    end
  end

  def destroy
    user = GameTranslator::User.find(params[:id])
    if user.destroy
      flash[:sucess] = 'Cadastro deletado!'
      redirect_to user_index_path
    else
      render action: :edit
    end
  end

  private

  def needs_password?(user, params)
    params[:game_translator_user][:password].present?
  end
end