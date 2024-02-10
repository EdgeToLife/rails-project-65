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
      get '/', to: 'home#index', as: 'profile'

      resources :home, only: %i[archive index publish reject show] do
        %i[archive publish reject].each { |action| patch action, on: :member }
      end

      resources :bulletins, only: %i[archive index show publish reject] do
        %i[archive publish reject].each { |action| patch action, on: :member }
      end

      resources :categories
    end

    get '/profile', to: 'user#user_profile'
  end
end
