# encoding: UTF-8

require 'spec_helper'

describe 'Authorization' do
  context 'when user is reviser' do
    before do
      reviser = create(:game_translator_user, password: '123123123', password_confirmation: '123123123', role: 'reviser')
      visit('/')

      fill_in 'user_email', with: reviser.email
      fill_in 'user_password', with: reviser.password
      click_button 'Entrar'
    end

    it 'should give access to users, languages, stats, and reviews page' do
      page.should have_content('Cadastro de Usuários')
      page.should have_content('Cadastro de Idiomas')
      page.should have_content('Estatísticas')
      page.should have_content('Revisões')
      page.should_not have_content('Traduzir')
    end
  end

  context 'when user is translator' do
    before do
      translator = create(:game_translator_user, password: '123123123', password_confirmation: '123123123', role: 'translator')
      visit('/')

      fill_in 'user_email', with: translator.email
      fill_in 'user_password', with: translator.password
      click_button 'Entrar'
    end

    it 'should give access to translate page' do
      page.should have_content('Traduzir')
      page.should_not have_content('Cadastro de Usuários')
      page.should_not have_content('Cadastro de Idiomas')
      page.should_not have_content('Estatísticas')
      page.should_not have_content('Revisões')
    end
  end
end