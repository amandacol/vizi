Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :profiles, only: %i[new create]
  resources :users, only: [:show]
  resources :items do
    resources :orders, except: :index
  end
  resources :orders, only: [:index]

end
