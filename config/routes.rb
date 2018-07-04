Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  get 'portfolio', to: 'users#portfolio'
  get 'search_stocks', to: 'stocks#search'

  resources :user_stocks, only: [:create, :destroy]


end
