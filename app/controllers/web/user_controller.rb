# frozen_string_literal: true

class Web::UserController < ApplicationController
  def user_profile
    @search = current_user.bulletins.order('created_at DESC').ransack(params[:q])
    @user_bulletins = @search.result(distinct: true)
    render 'web/bulletins/user_profile'
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :state, :image)
  end
end
