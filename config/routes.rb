Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'listings#index'

  resources :listings

  get '/users/posts', to: 'listings#posts', as: 'posts'
  get '/users/orders', to: 'listings#orders', as: 'orders'
  patch '/listings/:id/buy', to: 'listings#buy', as: 'buy'
end
