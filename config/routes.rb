Rails.application.routes.draw do
  root 'welcome#index'
  resources :events, only: [:index, :new, :create]
  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  resource :sessions, only: [:destroy]
  resources :confirmations, only: [:show], param: :token
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
