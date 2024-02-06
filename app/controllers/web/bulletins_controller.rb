class Web::BulletinsController < ApplicationController
  def index
    @bulletins = Bulletin.where(state: 'published').includes(:creator).order('created_at DESC')
  end

  def new
    if user_signed_in?
      @bulletin = current_user.bulletins.build
    else
      redirect_to root
    end
  end

  def create
    @categories = Category.all
    @bulletin = current_user.bulletins.new(bulletin_params)

    if @bulletin.save
      redirect_to bulletin_url(@bulletin), notice: t('.create_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  def user_profile
    @user_bulletins = current_user.bulletins.order('created_at DESC')
  end

  def admin
    @bulletins = Bulletin.includes(:creator).order('created_at DESC')
  end

  def to_moderate
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.aasm.current_state == :draft
        @bulletin.to_moderate!
    end
    redirect_to user_profile_path
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
    params.require(:bulletin).permit(:title, :description, :category_id)
  end
end
