Rails.application.routes.draw do
  get 'search/show'

  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'

  resources :users do
    member do
      get :following, :followers
    end

  end
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :account_activations, only: [:edit]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :microposts, only: [:create, :destroy]

  resources :relationships, only: [:create, :destroy]

  resources :hastags, only: [:show]

  resource :search, only: [:show]
end
