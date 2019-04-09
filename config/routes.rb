Rails.application.routes.draw do

  ## Login
  devise_for :users
  namespace :api do
    get :search, to: 'search#index'
  end

  ## Admin
  namespace :admin do
    resources :movies
    resources :series
    resources :lists do
      resources :list_items, path: :items
    end
    resources :festivals, except: :show do
      resources :awards
    end
    resources :categories do
      resources :categories
    end
    post :import, to: 'media#import'
    root to: "movies#index"
  end

  ## Site
  resources :people, only: :show do
    resource :favorite
  end
  resources :movies do
    resource :favorite
    resource :reviews
  end
  resources :series do
    resources :seasons do
      resources :episodes
    end
    resource :favorite
    resources :reviews
  end
  resources :users, only: :show do
    resource :follow
  end

  root to: 'pages#index'

  require 'sidekiq/web'
  authenticate :user, lambda { |user| user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/static/show', to: 'static#show'
  get '/static/search', to: 'static#search'
  get '/static/profile', to: 'static#profile'
end
