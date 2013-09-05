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
        Translation.revised.count
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

      def count_translations(user)
        return 'Nenhum tradutor cadastrado!' if user.nil?
        user.translations.count
      end
    end
  end
end