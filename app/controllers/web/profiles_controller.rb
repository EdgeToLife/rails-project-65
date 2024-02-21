# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    def show
      if current_user.present?
        user_authorize
        @search = current_user.bulletins.order('created_at DESC').ransack(params[:q])
        @user_bulletins = @search.result.page(params[:page]).per(10)
        # render :user_profile
      else
        flash[:alert] = t('.not_allowed')
        redirect_to root_path
      end
    end
  end
end
