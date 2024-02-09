# frozen_string_literal: true

class Web::UserController < ApplicationController
  def user_profile
    @search = current_user.bulletins.order('created_at DESC').ransack(params[:q])
    @user_bulletins = @search.result(distinct: true).page(params[:page]).per(10)
    render 'web/bulletins/user_profile'
  end
end
