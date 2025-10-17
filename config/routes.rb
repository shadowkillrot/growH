Rails.application.routes.draw do
  get "pages/home"
  devise_for :users
 
  authenticated :user do
    root "dashboard#index", as: :authenticated_root
  end
  
  root "pages#home"
  
  resources :habits do
    resources :progress_logs, only: [:create]
  end
  
  get "dashboard", to: "dashboard#index"
end
