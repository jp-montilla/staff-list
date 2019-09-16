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

  get 'question/answer/:id' => 'question#new', as: :answer_create
  post 'question/create_text' => 'question#create_answer_text', as: :answer_text
  post 'question/create_numerical' => 'question#create_answer_numerical', as: :answer_numerical
  post 'question/create_choice' => 'question#create_answer_choice', as: :answer_choice

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
