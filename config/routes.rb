# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up', to: 'rails/health#show', as: :rails_health_check

  scope module: :web do
    root 'bulletins#index'

    resources :bulletins, only: %i[new create edit update index show] do
      patch :to_moderate, on: :member
      patch :archive, on: :member
    end

    post '/auth/:provider', to: 'auth#request', as: :auth_request
    get '/auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete '/auth', to: 'auth#destroy', as: :destroy_user_session

    namespace :admin do
      root 'home#index'

      resources :home, only: %i[index]

      resources :bulletins, only: %i[index] do
        patch :archive, on: :member
        patch :publish, on: :member
        patch :reject, on: :member
      end

      resources :categories, only: %i[create destroy edit index new update]
    end

    # get 'profile', action: :profile, controller: 'user'
    resource :profile, only: %i[show]
  end
end
