# frozen_string_literal: true

require 'test_helper'

module Web
  class UserControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
    end

    test 'should get index' do
      sign_in @user
      get profile_url
      assert_response :success
    end

    test 'should not get index' do
      get profile_url
      assert_redirected_to root_path
    end
  end
end
