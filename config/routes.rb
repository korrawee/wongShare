Rails.application.routes.draw do
  resources :baanshares,shallow: true do
    resources :wongshares
  end
  get 'baanshares/:id', to: 'baanshares#show'
  get 'summary/', to: "summary#index"
  get 'wongshare/new', to: 'wongshares#new'
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "main#index"
  # get '/accounts/sign_in', to: 'sessions#new'
  # post '/accounts/sign_in', to: 'sessions#create'
end
