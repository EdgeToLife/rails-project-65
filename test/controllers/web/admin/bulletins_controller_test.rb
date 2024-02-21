# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @bulletin = bulletins(:under_moderation)
      end

      test 'should get admin bulletins index page' do
        sign_in @admin
        get admin_bulletins_url
        assert_response :success
      end

      test 'should move bulletin to published' do
        sign_in @admin
        patch publish_admin_bulletin_path(@bulletin)
        @bulletin.reload
        assert @bulletin.published?
        assert_redirected_to admin_root_url
      end

      test 'should reject bulletin' do
        sign_in @admin
        patch reject_admin_bulletin_path(@bulletin)
        @bulletin.reload
        assert @bulletin.rejected?
        assert_redirected_to admin_root_url
      end

      test 'should archive bulletin' do
        sign_in @admin
        patch archive_admin_bulletin_path(@bulletin), headers: {
          'HTTP_REFERER' => 'http://www.example.com/admin/bulletins'
        }
        @bulletin.reload
        assert @bulletin.archived?
        assert_redirected_to admin_bulletins_url
      end
    end
  end
end
