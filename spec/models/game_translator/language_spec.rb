require 'spec_helper'

describe GameTranslator::Language do
  it 'has a valid generator' do
    create(:game_translator_language).should be_valid
  end

  it 'has a name' do
    build(:game_translator_language, name: nil).should_not be_valid
    build(:game_translator_language, name: '').should_not be_valid
  end

  it 'has a code' do
    build(:game_translator_language, code: nil).should_not be_valid
    build(:game_translator_language, code: '').should_not be_valid
  end

  it 'has a valid code' do
    build(:game_translator_language, code: 'foo').should_not be_valid
    build(:game_translator_language, code: 'bar').should_not be_valid
    build(:game_translator_language, code: 'de').should be_valid
  end

  describe '.codes' do
    subject { GameTranslator::Language }

    it { should respond_to :codes }

    it 'returns an array of codes' do
      create(:game_translator_language, name: 'English', code: 'en')
      codes = GameTranslator::Language.codes
      codes.should_not include 'English'
      codes.should include 'en'
    end
  end
end