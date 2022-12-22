Rails.application.routes.draw do
  
  get 'users/index'
  root 'pages#home'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :projects do
    resources :tasks
  end
  resources :tasks do
    collection do
      get :task_dashboard
    end
  end
  devise_for :users
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'
  resources :users, :only =>[:show]
  # root to: "projects#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end 

