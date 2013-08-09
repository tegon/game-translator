require 'spec_helper'

describe 'Authentication' do
  before do
    @reviser = create(:game_translator_user, password:'123123123', password_confirmation: '123123123', role: 'reviser')
    @translator = create(:game_translator_user, password:'123123123', password_confirmation: '123123123', role: 'translator')
  end

  context 'User not logged in' do
    it 'should open the login path' do
      visit('/')

      current_path.should == '/users/login'
    end

    it 'should not log in if email is invalid' do
      visit('/')

      fill_in 'user_email', with: 'foo@bar.com'
      fill_in 'user_password', with: @reviser.password
      click_button 'Entrar'

      current_path.should == '/users/login'
    end

    it 'should not log in if password is invalid' do
      visit('/')

      fill_in 'user_email', with: @reviser.email
      fill_in 'user_password', with: '12345678'
      click_button 'Entrar'

      current_path.should == '/users/login'
    end
  end

  context 'Reviser logged in' do
    before do
      visit root_path
      fill_in 'user_email', with: @reviser.email
      fill_in 'user_password', with: @reviser.password
      click_button 'Entrar'
    end

    it 'should be redirected to the users path' do
      visit('/')

      current_path.should == '/users'
    end

    it 'should be able to access users root' do
      visit('/languages')

      current_path.should == '/languages'
    end
  end

  context 'Translator logged in' do
    before do
      visit root_path
      fill_in 'user_email', with: @translator.email
      fill_in 'user_password', with: @translator.password
      click_button 'Entrar'
    end

    it 'should be able to open the root path' do
      visit('/')

      current_path.should == '/'
    end
  end
end