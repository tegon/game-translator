class GameTranslator::StatsController < ApplicationController
  def index
    @total = GameTranslator::Stat.total
    @translated = GameTranslator::Stat.translated
    @revised = GameTranslator::Stat.revised
    @greatest_translator = GameTranslator::Stat.greatest_translator
    @count_translations = GameTranslator::Stat.count_translations(@greatest_translator)
    @percentage = GameTranslator::Stat.percentage
  end
end