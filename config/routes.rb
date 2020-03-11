Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :profiles, only: %i[new create]
  resources :users, only: [:show, :index]
  resources :items do
    resources :wishlists, except: :index
    resources :reviews, only: [:create]
    resources :orders, only: [:create]
  end
  resources :wishlists, only: [:index]
  resources :orders, only: [:index, :edit, :update, :destroy] do
    resources :payments, only: :new
  end
  end


