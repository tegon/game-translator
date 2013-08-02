require 'spec_helper'

describe GameTranslator::Language do 
	it 'should have a valid generator' do
		create(:game_translator_language).should be_valid
	end

	it 'should have a name' do 
		build(:game_translator_language, name: nil).should_not be_valid
		build(:game_translator_language, name: '').should_not be_valid
	end

	it 'should have a abbreviation' do
		build(:game_translator_language, abbreviation: nil).should_not be_valid
		build(:game_translator_language, abbreviation: '').should_not be_valid
	end

	it 'should have a valid abbreviation' do
		build(:game_translator_language, abbreviation: 'a').should_not be_valid
		build(:game_translator_language, abbreviation: 'abcdef').should_not be_valid
		build(:game_translator_language, abbreviation: 'ab-cd').should be_valid
	end

	describe '#abbreviations' do 
		it 'should have a abbreviations method' do
			GameTranslator::Language.should respond_to :abbreviations		
		end

		it 'should return an array of abbreviations' do 
			create(:game_translator_language, name: 'English', abbreviation: 'en')
			abbreviations = GameTranslator::Language.abbreviations
			abbreviations.should_not include 'English'
			abbreviations.should include 'en'
		end
	end
end