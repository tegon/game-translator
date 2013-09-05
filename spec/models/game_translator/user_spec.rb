require 'spec_helper'

describe GameTranslator::User do
  it 'has a valid generator' do
    create(:game_translator_user).should be_valid
  end

  it 'has an email' do
    build(:game_translator_user, email: nil).should_not be_valid
    build(:game_translator_user, email: '').should_not be_valid
  end

  it 'has a valid email' do
    build(:game_translator_user, email: 'foo').should_not be_valid
    build(:game_translator_user, email: 'foo@').should_not be_valid
    build(:game_translator_user, email: '@bar').should_not be_valid
    build(:game_translator_user, email: 'foo@bar').should_not be_valid
    build(:game_translator_user, email: 'foo@bar.com').should be_valid
  end

  it 'has a name' do
    build(:game_translator_user, name: nil).should_not be_valid
    build(:game_translator_user, name: '').should_not be_valid
  end

  it 'has a valid name' do
    build(:game_translator_user, name: 'a').should_not be_valid
    build(:game_translator_user, name: 'ab').should_not be_valid
    build(:game_translator_user, name: 'abc').should be_valid
  end

  it 'has a password' do
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

  it 'has a role' do
    build(:game_translator_user, role: nil).should_not be_valid
    build(:game_translator_user, role: '').should_not be_valid
  end

  it 'has a valid role' do
    build(:game_translator_user, role: 'foo').should_not be_valid
  end

  describe '#reviser?' do
    subject { create(:game_translator_user, role: 'reviser') }

    it { should be_reviser }

    it { should_not be_translator }
  end

  describe '#translator?' do
    subject { create(:game_translator_user, role: 'translator') }

    it { should be_translator }

    it { should_not be_reviser }
  end

  it { should respond_to :translations }
end