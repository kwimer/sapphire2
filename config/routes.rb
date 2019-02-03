Rails.application.routes.draw do
  namespace :admin do
    resources :movies
    resources :series
    root to: "movies#index"
  end
end
