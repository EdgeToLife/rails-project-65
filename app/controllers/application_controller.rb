class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_user, :user_signed_in?

  def user_signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private

  def user_not_authorized
    flash[:alert] = t('.not_allowed')
    redirect_back(fallback_location: root_path)
  end
end
