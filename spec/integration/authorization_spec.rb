# encoding: UTF-8

require 'spec_helper'

describe 'Authorization' do
  context 'when user is reviser' do
    let(:reviser) { create(:game_translator_user, role: 'reviser') }

    before do
      visit root_path
      fill_in 'user_email', with: reviser.email
      fill_in 'user_password', with: reviser.password
      click_button 'Entrar'
    end

    it 'gives access to users page' do
      page.should have_content('Usuários')
    end

    it 'gives access to languages page' do
      page.should have_content('Idiomas')
    end

    it 'gives access to stats page' do
      page.should have_content('Estatísticas')
    end

    it 'gives access to reviews page' do
      page.should have_content('Revisões')
    end

    it 'does not give access to translate page' do
      page.should_not have_content('Traduzir')
    end
  end

  context 'when user is translator' do
    let(:translator) { create(:game_translator_user, role: 'translator') }

    before do
      visit root_path
      fill_in 'user_email', with: translator.email
      fill_in 'user_password', with: translator.password
      click_button 'Entrar'
    end

    it 'gives access to translate page' do
      page.should have_content('Traduzir')
    end

    it 'does not give access to languages page' do
      page.should_not have_content('Cadastro de Idiomas')
    end

    it 'does not give access to stats page' do
      page.should_not have_content('Estatísticas')
    end

    it 'does not give access to reviews page' do
      page.should_not have_content('Revisões')
    end

    it 'does not give access to users page' do
      page.should_not have_content('Cadastro de Usuários')
    end
  end
end