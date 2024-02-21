# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @category = categories(:one)
        @empty_category = categories(:five)
      end

      test 'should get category index page' do
        sign_in @admin
        get admin_categories_url
        assert_response :success
      end

      test 'should get category new page' do
        sign_in @admin
        get new_admin_category_url
        assert_response :success
      end

      test 'should create category' do
        sign_in @admin
        attrs = { name: 'TestCategory' }
        assert_difference('Category.count') do
          post admin_categories_url, params: { category: attrs }
        end
        created_category = Category.last
        assert_equal attrs[:name], created_category.name
        assert_redirected_to admin_categories_url
      end

      test 'should get category edit page' do
        sign_in @admin
        get edit_admin_category_url(@category)
        assert_response :success
      end

      test 'should update category' do
        sign_in @admin
        attrs = { name: 'UpdatedCategoryName' }
        patch admin_category_url(@category), params: { category: attrs }
        @category.reload
        assert_equal attrs[:name], @category.name
        assert_redirected_to admin_categories_url
      end

      test 'should not destroy category which has depended bulletins' do
        sign_in @admin
        assert_no_difference('Category.count') do
          delete admin_category_url(@category)
        end
        assert_redirected_to admin_category_url(@category)
      end

      test 'should destroy category without dependencies' do
        sign_in @admin
        assert_difference('Category.count', -1) do
          delete admin_category_url(@empty_category)
        end
        assert_redirected_to admin_categories_url
      end
    end
  end
end
