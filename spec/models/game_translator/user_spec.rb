require 'spec_helper'

describe GameTranslator::User do
  it 'should have a valid generator' do
    create(:game_translator_user).should be_valid
  end

  it 'should have an email' do
    build(:game_translator_user, email: nil).should_not be_valid
    build(:game_translator_user, email: '').should_not be_valid
  end

  it 'should have a valid email' do
    build(:game_translator_user, email: 'foo').should_not be_valid
    build(:game_translator_user, email: 'foo@').should_not be_valid
    build(:game_translator_user, email: '@bar').should_not be_valid
    build(:game_translator_user, email: 'foo@bar').should_not be_valid
    build(:game_translator_user, email: 'foo@bar.com').should be_valid
  end

  it 'should have a name' do
    build(:game_translator_user, name: nil).should_not be_valid
    build(:game_translator_user, name: '').should_not be_valid
  end

  it 'should have a valid name' do
    build(:game_translator_user, name: 'a').should_not be_valid
    build(:game_translator_user, name: 'ab').should_not be_valid
    build(:game_translator_user, name: 'abc').should be_valid
  end

  it 'should have a password' do
    build(:game_translator_user, password: nil).should_not be_valid
    build(:game_translator_user, password: '').should_not be_valid
    build(:game_translator_user, password: '1234567').should_not be_valid
  end

  it 'password should match with password confirmation' do
    build(:game_translator_user, password: '12345678',
      password_confirmation: '12345679').should_not be_valid
    build(:game_translator_user, password: '12345678',
      password_confirmation: '12345678').should be_valid
  end

  it 'should have a role' do
    build(:game_translator_user, role: nil).should_not be_valid
    build(:game_translator_user, role: '').should_not be_valid
  end

  it 'should have a valid role' do
    build(:game_translator_user, role: 'foo').should_not be_valid
  end

  describe '#reviser?' do
    it 'should be a reviser' do
      user = create(:game_translator_user, role: 'reviser')
      user.should be_reviser
      user.role = 'translator'
      user.should_not be_reviser
    end
  end

  describe '#translator?' do
    it 'should be a translator' do
      user = create(:game_translator_user, role: 'translator')
      user.should be_translator
      user.role = 'reviser'
      user.should_not be_translator
    end
  end

  it 'should have many translations' do
    user = create(:game_translator_user)
    user.should respond_to :translations
  end
end