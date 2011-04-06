class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :redirect_to_international

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil? rescue nil
  end

  def redirect_to_international
    return unless request.host.match /\.br/ and Rails.env == "production"
    url = request.protocol + request.host_with_port.sub(/^(www\.)?w3triad\.com\.br/, '\1w3triad.com') + request.fullpath
    lang_opt = request.request_uri.match(/\?/) ? "&lang=pt" : "?lang=pt"
    redirect_to url + lang_opt, :status => :moved_permanently
  end
end
