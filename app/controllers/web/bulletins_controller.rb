# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :user_authorize, only: [:new, :create]

    def index
      @search = Bulletin.where(state: 'published').order('created_at DESC').ransack(params[:q])
      @bulletins = @search.result.page(params[:page]).per(12)
    end

    def show
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def new
      @bulletin = current_user.bulletins.build
    end

    def edit
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def create
      @bulletin = current_user.bulletins.new(bulletin_params)
      if @bulletin.save
        redirect_to bulletin_url(@bulletin), notice: t('.create_success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def to_moderate
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.to_moderate! if @bulletin.may_to_moderate?
      redirect_to profile_path, notice: t('.to_moderate_success')
    end

    def update
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      if @bulletin.update(bulletin_params)
        redirect_to bulletin_url(@bulletin), notice: t('.update_success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def archive
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.archive! if @bulletin.may_archive?
      redirect_to profile_path, notice: t('.archive_success')
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
