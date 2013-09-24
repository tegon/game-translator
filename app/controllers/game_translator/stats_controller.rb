class GameTranslator::StatsController < ApplicationController
  def index
    @total = GameTranslator::Stat.total
    @translated = GameTranslator::Stat.translated
    @revised = GameTranslator::Stat.revised
    @greatest_translator = GameTranslator::Stat.greatest_translator
    @count_translations = GameTranslator::Stat.count_translations(@greatest_translator)
    @percentage = GameTranslator::Stat.percentage
  end

  def users_index
    @users = GameTranslator::User.translators.paginate(page: params[:page])
  end

  def user
    @user = GameTranslator::User.find(params[:id])

    if @user
      @translations = GameTranslator::Stat.count_translations(@user)
      @rejected = GameTranslator::Stat.count_translations(@user, 'rejected')
      @accepted = GameTranslator::Stat.count_translations(@user, 'accepted')
    end
  end

  def user_per_date
    @user = GameTranslator::User.find(params[:id])

    if params[:date_from] && params[:date_to]
      @date_from = Date.parse(params[:date_from])
      @date_to = Date.parse(params[:date_to])
      @translations_per_date = @user.translations.of_date(@date_from, @date_to).count
      render json: { date_from: @date_from.strftime('%d/%m/%y'), date_to: @date_to.strftime('%d/%m/%y'), translations: @translations_per_date }
    end
  end
end