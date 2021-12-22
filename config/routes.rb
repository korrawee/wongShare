Rails.application.routes.draw do
  get 'wongshare/new'
  get 'summary/', to: "summary#index"
  get 'baanshare/', to: 'baanshare#index'
  get 'baanshare/:id', to: 'baanshare#show'
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "main#index"
  # get '/accounts/sign_in', to: 'sessions#new'
  # post '/accounts/sign_in', to: 'sessions#create'
end
