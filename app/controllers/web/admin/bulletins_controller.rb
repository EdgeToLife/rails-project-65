# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def index
        @search = Bulletin.order('created_at DESC').ransack(params[:q])
        @bulletins = @search.result.page(params[:page]).per(10)
      end

      def archive
        @bulletin = Bulletin.find(params[:id])
        @bulletin.archive! if @bulletin.may_archive?
        redirect_back(fallback_location: admin_root_path, notice: t('.archive_success'))
      end

      def publish
        @bulletin = Bulletin.find(params[:id])
        @bulletin.publish! if @bulletin.may_publish?
        redirect_to admin_root_url, notice: t('.publish_success')
      end

      def reject
        @bulletin = Bulletin.find(params[:id])
        @bulletin.reject! if @bulletin.may_reject?
        redirect_to admin_root_url, notice: t('.reject_success')
      end
    end
  end
end
