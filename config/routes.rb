Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  scope module: :web do
    root 'bulletins#index'

    post '/auth/:provider', to: 'auth#request', as: :auth_request
    get '/auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete '/auth', to: 'auth#destroy', as: :destroy_user_session

    namespace :admin do
      get '/', to: 'admin#index', as: 'profile'
    end

    get '/profile', to: 'user#user_profile', as: 'user_profile'

    resources :bulletins, only: %i[new create edit update], shallow: true do
      member do
        patch :to_moderate
        patch :publish
        patch :reject
        patch :archive
      end
    end

    resources :bulletins, only: %i[index show]
  end
end
