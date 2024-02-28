# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class HomeControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
      end

      test 'should get admin profile' do
        sign_in @admin
        get admin_root_url
        assert_response :success
      end
    end
  end
end
