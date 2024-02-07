# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  def create
    @categories = Category.all
    @bulletin = current_user.bulletins.new(bulletin_params)

    if @bulletin.save
      redirect_to bulletin_url(@bulletin), notice: t('.create_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  def index
    @search = Bulletin.where(state: 'published').includes(:creator).order('created_at DESC').ransack(params[:q])
    @bulletins = @search.result(distinct: true)
  end

  def new
    if user_signed_in?
      @bulletin = current_user.bulletins.build
    else
      redirect_to root
    end
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def to_moderate
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.aasm.current_state == :draft
        @bulletin.to_moderate!
    end
    redirect_to user_profile_path
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.update(bulletin_params)
      redirect_to bulletin_url(@bulletin), notice: t('.update_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    @bulletin.archive!
    redirect_to user_profile_path
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :state, :category_id, :image)
  end
end
