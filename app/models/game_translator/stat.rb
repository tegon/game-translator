# encoding: UTF-8
module GameTranslator
  class Stat
    class << self
      def total
        GameTranslator::Game.count
      end

      def translated
        GameTranslator::Game.translated.count
      end

      def revised
        GameTranslator::Game::Translation.revised.count
      end

      def greatest_translator
        max = 0
        GameTranslator::User.translators.map do |user|
          if count_translations(user) >= max
            max = count_translations(user)
            @user = user
          end
        end
        return @user
      end

      def percentage
        return 0 if total.zero?
        (100 * translated/total.to_f).round
      end

      def count_translations(user, status = nil)
        return 'Tradutor não encontrado!' unless user
        translations = user.translations.scoped
        case status
        when 'accepted', 'rejected'
          translations.joins(:review).where(reviews: { status: status }).count
        when nil
          translations.count
        end
      end
    end
  end
end