# frozen_string_literal: true

class Web::Admin::ApplicationController < ApplicationController
  before_action :authorize_admin

  private

  def authorize_admin
    if current_user.present?
      authorize current_user, :access_admin_panel?
    else
      flash[:alert] = t('.not_allowed')
      redirect_to root_path
    end
  end
end
