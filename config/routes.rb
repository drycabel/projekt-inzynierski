Rails.application.routes.draw do
  root 'welcome#index'
  resources :events do
    resource :join_event, controller: :join_events, only: [:create], path: 'join'
    resource :quit_event, controller: :quit_events, only: [:destroy], path: 'quit'
    resources :invitations, only: [:create]
  end
  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  resource :sessions, only: [:destroy] do
    resource :reset_password, controller: :reset_passwords, only: [:new, :create, :edit, :update]
  end
  resources :confirmations, only: [:show], param: :token
  resources :invitations_refuse, only: [:show], param: :token_value
  resources :users, only: [:show, :destroy, :edit, :update] do
    resource :password, controller: :passwords, only: [:edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
