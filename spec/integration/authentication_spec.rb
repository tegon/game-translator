require 'spec_helper'

describe 'Authentication' do
  let(:reviser) { create(:game_translator_user, role: 'reviser') }
  let(:translator) { create(:game_translator_user, role: 'translator') }

  context 'User not logged in' do
    it 'opens the login path' do
      visit root_path
      current_path.should == '/users/login'
    end

    it 'does not log in if email is invalid' do
      visit root_path

      fill_in 'user_email', with: 'foo@bar.com'
      fill_in 'user_password', with: reviser.password
      click_button 'Entrar'

      current_path.should == '/users/login'
    end

    it 'does not log in if password is invalid' do
      visit root_path

      fill_in 'user_email', with: reviser.email
      fill_in 'user_password', with: '12345678'
      click_button 'Entrar'

      current_path.should == '/users/login'
    end
  end

  context 'Reviser logged in' do
    before do
      visit root_path
      fill_in 'user_email', with: reviser.email
      fill_in 'user_password', with: reviser.password
      click_button 'Entrar'
    end

    it 'is redirected to the users path' do
      visit root_path
      current_path.should eql(user_index_path)
    end

    it 'is able to access users root' do
      visit languages_path
      current_path.should eql(languages_path)
    end
  end

  context 'Translator logged in' do
    before do
      visit root_path
      fill_in 'user_email', with: translator.email
      fill_in 'user_password', with: translator.password
      click_button 'Entrar'
    end

    it 'is able to open the root path' do
      visit root_path
      current_path.should eql(root_path)
    end
  end
end