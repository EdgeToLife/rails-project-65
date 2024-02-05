class Web::BulletinsController < ApplicationController
  def index
    @bulletins = Bulletin.includes(:creator).order('created_at DESC')
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

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id)
  end
end
