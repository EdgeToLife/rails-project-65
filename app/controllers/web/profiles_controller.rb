# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    before_action :user_authorize

    def show
      @search = current_user.bulletins.order('created_at DESC').ransack(params[:q])
      @user_bulletins = @search.result.page(params[:page]).per(10)
    end
  end
end
