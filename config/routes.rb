Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :profiles, only: %i[new create]
  resources :users, only: [:show, :index]
  resources :items do
    resources :orders, except: [:index, :show, :create]
    resources :wishlists, except: :index
  end
  resources :orders, only: [:index, :show, :create] do
    resources :payments, only: :new
  end
  resources :wishlists, only: [:index]
end
