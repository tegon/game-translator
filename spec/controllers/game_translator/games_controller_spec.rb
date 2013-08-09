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

  describe 'GET translate' do
    it 'should render the translate games page' do
      sign_in @translator
      get :translate
      response.should render_template :translate
    end

    it 'should not get same games' do
      sign_in @translator
      get :translate
      assigns(@games)

      20.times do
        sign_in @translator2
        get :translate
        response.should_not include @games
      end
    end
  end
end