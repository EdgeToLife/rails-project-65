# frozen_string_literal: true

class Web::Admin::ApplicationController < ApplicationController
  before_action :authorize_admin

  private

  def authorize_admin
    authorize current_user, :access_admin_panel?
  end
end
