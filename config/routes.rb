Rails.application.routes.draw do
  root 'welcome#index'
  resources :events do
    # resource :dupa, only: [:show]
    resource :join_event, controller: :join_events, only: [:create], path: 'join'
    resource :quit_event, controller: :quit_events, only: [:destroy], path: 'quit'
    resources :invitations, only: [:create]
  end
  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create]
  resource :sessions, only: [:destroy]
  resources :confirmations, only: [:show], param: :token

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
