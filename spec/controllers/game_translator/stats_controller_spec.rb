require 'spec_helper'

describe GameTranslator::StatsController do
  let(:reviser) { create(:game_translator_user, role: 'reviser') }

  before { sign_in reviser }

  describe 'GET index' do
    it 'renders the stats index' do
      get :index
      response.should render_template :index
    end
  end
end