Rails.application.routes.draw do
  get "sessions/new"
  resources :content_lists

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  root to: 'content_lists#index'
  resources :content_lists, only: [:new, :create, :edit, :update, :destroy, :show], params: :title
  get "signup", to: "users#new"
  resources :users, except: [:new] do
    member do
      get :postbycurrent 
    end
  end

  # Session用のルートティングを設定
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get 'show_all_users', to: 'users#show_all'

  get 'show_all', to: 'content_lists#show_all'
  get 'user_six', to: 'content_lists#user_six'
  get 'user_all', to: 'content_lists#user_all'

  post "guest_login", to: "guest_sessions#create"

  # Defines the root path route ("/")
  # root "posts#index"
end
