# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:two)
        @bulletin = bulletins(:two)
      end

      test 'should get admin bulletins index page' do
        sign_in @admin
        get admin_bulletins_url
        assert_response :success
      end

      test 'should archive bulletin' do
        sign_in @admin
        patch archive_admin_bulletin_path(@bulletin)
        @bulletin.reload
        assert_equal 'archived', @bulletin.state
        assert_redirected_to admin_bulletins_url
      end
    end
  end
end
