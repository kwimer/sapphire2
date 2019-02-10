Rails.application.routes.draw do

  devise_for :users
  namespace :api do
    get :search, to: 'search#index'
  end

  namespace :admin do
    resources :categories do
      resources :categories
    end
    resources :festivals, except: :show do
      resources :awards
    end
    resources :movies do
      collection do
        get :search
      end
    end
    resources :series
    post :import, to: 'media#import'
    root to: "movies#index"
  end

  root to: 'pages#index'

  require 'sidekiq/web'
  authenticate :user, lambda { |user| user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
