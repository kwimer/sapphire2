Rails.application.routes.draw do
  namespace :admin do
    resources :categories do
      resources :categories
    end

    resources :movies
    resources :series
    root to: "movies#index"
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
