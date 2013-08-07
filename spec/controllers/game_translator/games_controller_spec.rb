require 'spec_helper'

describe GameTranslator::GamesController do
  before do 
    @reviser = create(:game_translator_user, role: 'reviser')
    @translator = create(:game_translator_user, role: 'translator')
    
    @game1 = create(:game_translator_game, name: 'Game1', status: 'not_translated')
    @game2 = create(:game_translator_game, name: 'Game2', status: 'not_translated')
    @game3 = create(:game_translator_game, name: 'Game3', status: 'not_translated')
    @game4 = create(:game_translator_game, name: 'Game4', status: 'not_translated')
  end

  describe 'GET edit_multiple' do
    it 'should render the games/translate' do
      sign_in @translator
      get :edit_multiple
      response.should render_template :edit_multiple
    end
  end
end