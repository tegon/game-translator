class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    case current_user.role
    when 'translator'
      redirect_to game_translate_path
    when 'reviser'
      redirect_to user_index_path
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { :locale => I18n.locale == I18n.default_locale ? nil : I18n.locale  }
  end
end