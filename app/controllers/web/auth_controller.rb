# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      user, = authenticate_user(auth)

      sign_in user

      redirect_to root_path, notice: t('.success')
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session.delete(:user_id)
    end

    def destroy
      sign_out
      redirect_to root_path, notice: t('.success')
    end

    private

    def auth
      request.env['omniauth.auth']
    end

    def authenticate_user(auth)
      existing_user = User.find_by(email: auth['info']['email'])
      email = auth[:info][:email].downcase
      name = auth[:info][:name]
      name = email if name.nil?
      user = existing_user || User.new(name:, email:)

      is_new = false

      ActiveRecord::Base.transaction do
        if user.new_record?
          is_new = true
          user.save!
        end
      end
      [user, is_new]
    end
  end
end
