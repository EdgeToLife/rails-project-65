class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :current_user, :user_signed_in?

  def user_signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

end
