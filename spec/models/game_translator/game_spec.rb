require 'spec_helper'

describe GameTranslator::Game do
	before(:all) do
		@game = create(:game_translator_game)
	end	

	it 'should have a valid generator' do
		create(:game_translator_game).should be_valid
	end

	it 'should have many translations' do 
		@game.should respond_to :translations
	end

	it 'should belongs to user' do
		@game.should respond_to :user
	end

	describe 'translated scope' do 
		it 'should have scope for translated games' do
			GameTranslator::Game.should respond_to :translated
		end

		it 'should return only translated games' do
			not_translated_game = create(:game_translator_game, translated: false)
			translated = GameTranslator::Game.translated
			translated.should_not include not_translated_game
			translated.should include @game
		end
	end

	describe 'not_translated scope' do 
		it 'should have a scope for not translated games' do 
			GameTranslator::Game.should respond_to :not_translated
		end

		it 'should return only not translated games' do
			not_translated_game = create(:game_translator_game, translated: false)
			not_translated = GameTranslator::Game.not_translated
			not_translated.should_not include @game
			not_translated.should include not_translated_game
		end
	end

	describe 'revised scope' do 
		it 'should have a scope revised games' do 
			GameTranslator::Game.should respond_to :revised
		end

		it 'should return only revised games' do
			not_revised_game = create(:game_translator_game, revised: false)
			revised = GameTranslator::Game.revised
			revised.should include @game
			revised.should_not include not_revised_game
		end
	end	

	describe 'not_revised scope' do 
		it 'should have a scope not revised games' do 
			GameTranslator::Game.should respond_to :not_revised
		end

		it 'should return only not revised games' do
			not_revised_game = create(:game_translator_game, revised: false)
			not_revised = GameTranslator::Game.not_revised
			not_revised.should_not include @game
			not_revised.should include not_revised_game
		end
	end	

	it 'should have a random scope' do
		GameTranslator::Game.should respond_to :random
	end

	describe '#locales' do
		it 'should have an locales method' do
			@game.should respond_to :locales
		end

		it 'should return an array with translations locales' do
			locales = @game.locales
			locales.should include @game.translation.locale
		end
	end
end