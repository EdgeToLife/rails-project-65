# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class HomeControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @bulletin = bulletins(:under_moderation)
      end

      test 'should get admin profile' do
        sign_in @admin
        get admin_url
        assert_response :success
      end

      test 'should move bulletin to published' do
        sign_in @admin
        patch publish_admin_home_path(@bulletin)
        @bulletin.reload
        assert_equal 'published', @bulletin.state
        assert_redirected_to admin_url
      end

      test 'should reject bulletin' do
        sign_in @admin
        patch reject_admin_home_path(@bulletin)
        @bulletin.reload
        assert_equal 'rejected', @bulletin.state
        assert_redirected_to admin_url
      end

      test 'should archive bulletin' do
        sign_in @admin
        patch archive_admin_home_path(@bulletin)
        @bulletin.reload
        assert_equal 'archived', @bulletin.state
        assert_redirected_to admin_url
      end
    end
  end
end
