# encoding: UTF-8
require 'spec_helper'

describe 'Internationalization' do
  let(:reviser) { create(:game_translator_user, role: 'reviser') }

  before do
    I18n.locale = :"pt-BR"
    visit root_path
    fill_in 'user_email', with: reviser.email
    fill_in 'user_password', with: reviser.password
    click_button 'Entrar'
    visit user_index_path
  end

  it 'displays links to change language' do
    page.should have_link('Português', { href: '/' })
    page.should have_link('English', { href: '/en/' })
    page.should have_link('Español', { href: '/es/' })
  end

  context 'when locale is en' do
    before { visit('/en/') }

    it 'displays greeting message' do
      page.should have_content("Hi, #{ reviser.name }!")
    end

    it 'displays the nav links' do
      page.should have_content('Users')
      page.should have_content('Languages')
      page.should have_content('Stats')
      page.should have_content('Reviews')
    end
  end

  context 'when locale is es' do
    before { visit('/es/') }

    it 'displays greeting message' do
      page.should have_content("Hola, #{ reviser.name }!")
    end

    it 'displays the nav links' do
      page.should have_content('Usuarios')
      page.should have_content('Idiomas')
      page.should have_content('Estadísticas')
      page.should have_content('Revisiones')
    end
  end

  context 'when locale is pt-BR' do
    it 'displays greeting message' do
      page.should have_content("Olá, #{ reviser.name }!")
    end

    it 'displays the nav links' do
      page.should have_content('Usuários')
      page.should have_content('Idiomas')
      page.should have_content('Estatísticas')
      page.should have_content('Revisões')
    end
  end
end