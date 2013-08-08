require 'spec_helper'

describe GameTranslator::GamesController do
  before do 
    @translator = create(:game_translator_user, role: 'translator')
    @translator2 = create(:game_translator_user, role: 'translator')
    
    @games = [
      create(:game_translator_game, name: 'Game 1', status: 'not_translated'),
      create(:game_translator_game, name: 'Game 2', status: 'not_translated'),
      create(:game_translator_game, name: 'Game 3', status: 'not_translated'),
      create(:game_translator_game, name: 'Game 4', status: 'not_translated')
    ]

    10.times do 
      create(:game_translator_game, status: 'not_translated')
    end
  end

  describe 'GET edit_multiple' do
    it 'should render the games/translate' do
      sign_in @translator
      get :edit_multiple
      response.should render_template :edit_multiple
    end

    it 'should not get same games' do
      sign_in @translator
      get :edit_multiple
      assigns(@games)

      20.times do
        sign_in @translator2
        get :edit_multiple
        response.should_not include @games
      end
    end
  end
end