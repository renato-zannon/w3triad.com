class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :set_lang

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil? rescue nil
  end

  def set_lang
    I18n.locale = get_lang_from_domain
  end

  def get_lang_from_domain
    request.host.split('.').last == 'br' ? :pt : :en
  end
end
