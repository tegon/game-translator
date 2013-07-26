class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  
  rescue_from CanCan::AccessDenied do |exception|
    case current_user.role
    when 'translator'
      redirect_to game_edit_multiple_path, alert: exception.message
    when 'reviser'
      redirect_to user_index_path, alert: exception.message
    end
  end
end