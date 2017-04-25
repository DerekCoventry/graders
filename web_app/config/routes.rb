Rails.application.routes.draw do
  get 'courses/configure'
  get 'courses/final'
  get 'courses/autofill'
  get 'courses/activate'
  get 'courses/requestgrader'
  get 'courses/removerequest'
  get 'courses/confirmgrader'
  get 'authenticate/staff'
  get 'directories/gatherdata'
  resources :directories
  get 'prereqs/gatherdata'
  resources :prereqs
  resources :feedbacks
  get 'authenticate/index'

  get 'authenticate/email'
  get 'authenticate/confirm'
  get 'courses/addgrader'
  resources :courses
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
