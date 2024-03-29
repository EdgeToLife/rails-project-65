# frozen_string_literal: true

require 'test_helper'

module Web
  class AuthControllerTest < ActionDispatch::IntegrationTest
    test 'check github auth' do
      post auth_request_path('github')
      assert_response :redirect
    end

    test 'create' do
      auth_hash = {
        provider: 'github',
        uid: '12345',
        info: {
          email: Faker::Internet.email,
          name: Faker::Name.first_name
        }
      }

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

      get callback_auth_url('github')
      assert_response :redirect

      user = User.find_by(email: auth_hash[:info][:email].downcase)

      assert user
      assert signed_in?
    end

    test 'should destroy session and redirect to root' do
      user = users(:user)
      sign_in user

      delete destroy_user_session_url

      assert_nil session[:user_id]
      assert_redirected_to root_path
    end
  end
end
