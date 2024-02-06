Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  scope module: :web do
    post '/auth/:provider', to: 'auth#request', as: :auth_request
    get '/auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete '/auth', to: 'auth#destroy', as: :destroy_user_session
    get '/profile', to: 'bulletins#user_profile', as: :user_profile
    get '/admin', to: 'bulletins#admin'

    resources :bulletins, only: %i[index new create show edit destroy] do
      member do
        patch :to_moderate
        patch :publish
        patch :reject
        patch :archive
      end
    end
  end

  # Defines the root path route ("/")
  root "web/bulletins#index"
end
