# frozen_string_literal: true

module Web
  module Admin
    class HomeController < ApplicationController
      def archive
        @bulletin = Bulletin.find(params[:id])
        @bulletin.archive!
        redirect_to admin_profile_url, notice: t('.archive_success')
      end

      def index
        @bulletins = Bulletin.where(state: 'under_moderation').order('created_at DESC').page(params[:page]).per(10)
      end

      def publish
        @bulletin = Bulletin.find(params[:id])
        @bulletin.publish! if @bulletin.may_publish?
        redirect_to admin_profile_url, notice: t('.publish_success')
      end

      def reject
        @bulletin = Bulletin.find(params[:id])
        @bulletin.reject! if @bulletin.may_reject?
        redirect_to admin_profile_url, notice: t('.reject_success')
      end
    end
  end
end
