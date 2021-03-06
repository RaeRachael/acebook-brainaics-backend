Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password,
             controller: "clearance/passwords",
             only: [:create, :edit, :update]
  end

  # get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/users" => 'users#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/wall/:id' => "wall#new"
  resources :posts
  resources :wall
  root to: 'sessions#new'

  scope '/api/v1' do
    resources :wall
    resources :posts
    post "/sign_in" => "sessions#new", as: "sign_in"
    get "/users" => 'users#index'
  end
end
