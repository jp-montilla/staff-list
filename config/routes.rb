Rails.application.routes.draw do
  root 'homepage#index'

  namespace :admin do
    resources :employees
    resources :questions
    resources :choices
    # resources :answers
    resources :materials
    # resources :assigneds

    root to: "employees#index"
  end

  devise_for :employees

  resources :homepage
  # resources :answer

  post 'answer/create' => 'answer#create', as: :answer_create

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
