Rails.application.routes.draw do
  resources :baanshares,shallow: true do
    member do
      post :pay_all
      post :pay
    end
    resources :wongshares do
      member do
        post :bit
        post :pay
      end
    end
  end
  get 'baanshares/:id', to: 'baanshares#show'
  post 'baanshares/:id', to: 'baanshares#delete'
  get 'summary/', to: "summary#index"
  get 'wongshare/new', to: 'wongshares#new'
  post '/wongshare/new/', to: 'wongshares#new'
  patch 'wongshares/:id/edit', to: 'wongshares#edit'
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "main#index"
  # get '/accounts/sign_in', to: 'sessions#new'
  # post '/accounts/sign_in', to: 'sessions#create'
end
