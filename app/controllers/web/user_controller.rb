# frozen_string_literal: true

module Web
  class UserController < ApplicationController
    def user_profile
      if current_user.present?
        @search = current_user.bulletins.order('created_at DESC').ransack(params[:q])
        @user_bulletins = @search.result(distinct: true).page(params[:page]).per(10)
        authorize current_user, :access_profile?
        render 'web/bulletins/user_profile'
      else
        flash[:alert] = t('.not_allowed')
        redirect_to root_path
      end
    end
  end
end
