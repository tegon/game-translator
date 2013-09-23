#encoding: UTF-8
require 'spec_helper'

describe 'Language' do
  let(:reviser) { create(:game_translator_user, role: 'reviser') }

  before do
    visit root_path
    fill_in 'Email', with: reviser.email
    fill_in 'Senha', with: reviser.password
    click_button 'Entrar'
    visit languages_path
  end

  it 'creates language with valid data' do
    click_link 'Novo Idioma'
    fill_in 'Nome', with: 'Espanhol'
    fill_in 'Sigla', with: 'es'
    click_button 'Salvar'
    page.should have_content 'Idioma cadastrado com sucesso!'
  end

  it 'does not create language with blank values' do
    click_link 'Novo Idioma'
    click_button 'Salvar'
    page.should_not have_content 'Idioma cadastrado com sucesso!'
  end

  it 'does not create language with invalid data', js: true do
    click_link 'Novo Idioma'
    fill_in 'Nome', with: 'Foo'
    fill_in 'Sigla', with: 'bar'
    click_button 'Salvar'
    page.should have_content('Sigla não está incluído na lista')
  end
end