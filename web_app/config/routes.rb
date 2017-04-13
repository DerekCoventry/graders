Rails.application.routes.draw do
  resources :recommendations
  get 'professors/index'

  get 'professors/recommendations'

  get 'students/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :schedules
  resources :applicants
  get 'home/index'

  resources :tests
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
