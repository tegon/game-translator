require 'spec_helper'

describe GameTranslator::StatsController do
  before do
    @reviser = create(:game_translator_user, role: 'reviser')
    @translator = create(:game_translator_user, role: 'translator')

    sign_in @reviser

    10.times { create(:game_translator_game, status: 'translated') }

    10.times { create(:game_translator_game, status: 'not_translated') }

    10.times { create(:game_translator_game_translation, revised: true, user_id: @translator.id) }
  end

  describe 'GET index' do
    it 'renders the stats index' do 
      get :index
      response.should render_template :index
    end
  end
end
