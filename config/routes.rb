Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :profiles, only: %i[new create]
  resources :users, only: [:show, :index]
  resources :items do
    resources :orders, except: :index
    resources :wishlists, except: :index
  end
  resources :orders, only: [:index]
  resources :wishlists, only: [:index]
end
