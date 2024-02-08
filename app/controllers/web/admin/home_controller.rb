# frozen_string_literal: true

module Web
  module Admin
    class HomeController < ApplicationController
      def archive
        @bulletin = Bulletin.find(params[:id])
        @bulletin.archive!
        redirect_to admin_profile_url
      end

      def index
        @bulletins = Bulletin.where(state: 'under_moderation').order('created_at DESC')
      end

      def publish
        @bulletin = Bulletin.find(params[:id])
        if @bulletin.aasm.current_state == :under_moderation
          @bulletin.publish!
        end
        redirect_to admin_profile_url
      end

      def reject
        @bulletin = Bulletin.find(params[:id])
        if @bulletin.aasm.current_state == :under_moderation
          @bulletin.reject!
        end
        redirect_to admin_profile_url
      end

    end
  end
end
