# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < ApplicationController
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
  end
end
