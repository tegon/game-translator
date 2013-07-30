require 'spec_helper'

describe GameTranslator::GamesController do
  before do 
    @reviser = create(:game_translator_user, role: 'reviser')
    @translator = create(:game_translator_user, role: 'translator')
    
    @game1 = create(:game_translator_game, name: 'Game1')
    @game2 = create(:game_translator_game, name: 'Game2')
    @game3 = create(:game_translator_game, name: 'Game3')
    @game4 = create(:game_translator_game, name: 'Game4')
    @games = @game1, @game2, @game3, @game4
  end

  describe 'GET edit_multiple' do
    context 'when not logged in' do
      it 'should redirect to login page' do
        get :edit_multiple, games: @games
        response.should redirect_to new_user_session_path
      end
    end

    context 'when user is reviser' do
      it 'should redirect to users index' do
        sign_in @reviser
        get :edit_multiple, games: @games
        response.should redirect_to user_index_path
      end
    end

    context 'when user is translator' do
      it 'should render the games/translate' do
        sign_in @translator
        get :edit_multiple, games: @games
        response.should render_template :edit_multiple
      end
    end
  end
end