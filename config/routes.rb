Rails.application.routes.draw do

  devise_for :users
  namespace :api do
    get :search, to: 'search#index'
  end

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

  resources :users, only: :show do
    resource :follow
  end
  resources :series, only: :show do
    resource :favorite
  end
  resources :movies, only: :show do
    resource :favorite
  end
  root to: 'pages#index'

  require 'sidekiq/web'
  authenticate :user, lambda { |user| user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
