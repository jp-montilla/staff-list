Rails.application.routes.draw do
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
  root 'landing#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
