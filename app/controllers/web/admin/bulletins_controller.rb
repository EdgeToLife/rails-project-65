# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      def admin
        @search = Bulletin.includes(:creator, :category).order('created_at DESC').ransack(params[:q])
        @bulletins = @search.result(distinct: true)
      end

      def publish
        @bulletin = Bulletin.find(params[:id])
        if @bulletin.aasm.current_state == :under_moderation
          @bulletin.publish!
        end
        redirect_to user_profile_path
      end

      def archive
        @bulletin = Bulletin.find(params[:id])
        @bulletin.archive!
        redirect_to user_profile_path
      end

      def reject
        @bulletin = Bulletin.find(params[:id])
        if @bulletin.aasm.current_state == :under_moderation
          @bulletin.reject!
        end
        redirect_to user_profile_path
      end

      private

      def bulletin_params
        params.require(:bulletin).permit(:title, :description, :category_id, :image)
      end
    end
  end
end
