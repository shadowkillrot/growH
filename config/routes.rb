Rails.application.routes.draw do
  devise_for :users
 
  authenticated :user do
    root "dashboard#index", as: :authenticated_root
  end
  
  root "pages#home"
  
  resources :habits do
    resources :progress_logs, only: [:create]
  end
  
  get "dashboard", to: "dashboard#index"
  
  # Health check endpoint for Heroku
  get "up", to: "rails/health#show", as: :rails_health_check
end
