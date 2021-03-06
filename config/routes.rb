Rails.application.routes.draw do
  get 'braintree/new'
  
  get 'braintree/paid'
  
  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/features'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :edit, :update, :show] do
    resources :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :visitors, except: [:edit]
    resources :conversations, only: [:index]
  end

  resources :units

  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end

  resources :facilities, only: [:index]
    
  resources :reservations, only: [:create, :index]

  resources :maintenances

  post 'braintree/checkout'
  

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  root "welcome#index"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
end
