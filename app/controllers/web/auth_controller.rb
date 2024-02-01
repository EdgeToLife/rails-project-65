class Web::AuthController < ApplicationController
  def callback
    puts "Hello World"
    debugger
    result = authenticate_user(auth)

    sign_in result.user
    f(:success)
    js_event_options = {
      user: result.user
    }
    js_event(result.is_new ? :signed_up : :signed_in, js_event_options)
    redirect_to root_path
  end

  private

  def auth
    debugger
    request.env['omniauth.auth']
  end

  def authenticate_user(auth)
    debugger
    existing_account = User::Account.find_by(uid: auth[:uid])
    email = auth[:info][:email].downcase
    user = if existing_account
             existing_account.user
           else
             User.find_or_initialize_by(email: email)
           end

    is_new = false

    ActiveRecord::Base.transaction do
      if user.new_record?
        is_new = true
        user.save!
      end

      account = user.accounts.find_or_initialize_by(provider: auth[:provider])
      account.uid = auth[:uid]
      account.save!
    end
    ServiceResult.success user: user, is_new: is_new
  end
end
