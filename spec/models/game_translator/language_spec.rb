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
		build(:game_translator_language, abbreviation: 'abcde').should_not be_valid
		build(:game_translator_language, abbreviation: 'ab').should be_valid
	end

	describe '#languages_abbreviations' do 
		it 'should have a languages_abbreviations method' do
			GameTranslator::Language.should respond_to :languages_abbreviations		
		end

		it 'should return an array of languages abbreviations' do 
			create(:game_translator_language, name: 'English', abbreviation: 'en')
			abbreviations = GameTranslator::Language.languages_abbreviations
			abbreviations.should_not include 'English'
			abbreviations.should include 'es'
		end
	end
end