# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < ApplicationController
      def index
        @categories = Category.all.page(params[:page]).per(10)
      end

      def new
        @category = Category.build
      end

      def create
        @category = Category.create(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t('.create_success')
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        @category = Category.find(params[:id])
      end

      def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('.create_success')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @category = Category.find(params[:id])
        if @category.destroy
          redirect_to admin_categories_url, notice: t('.destroy_success')
        else
          redirect_to admin_category_url(@category), alert: t('.destroy_failure')
        end
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
