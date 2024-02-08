# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @search = Bulletin.includes(:creator, :category).order('created_at DESC').ransack(params[:q])
        @bulletins = @search.result(distinct: true)
      end

      def archive
        @bulletin = Bulletin.find(params[:id])
        @bulletin.archive!
        redirect_to admin_bulletins_path
      end
    end
  end
end
