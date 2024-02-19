# frozen_string_literal: true

module Web
  module Admin
    class HomeController < ApplicationController
      def index
        @bulletins = Bulletin.where(state: 'under_moderation').order('created_at DESC').page(params[:page]).per(10)
      end
    end
  end
end
