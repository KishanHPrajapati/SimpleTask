Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :projects do
    resources :tasks
  end
  devise_for :users
  root to: "projects#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end 

