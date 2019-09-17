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
  post 'question/create' => 'question#create', as: :answer_question
  delete 'question/:id/delete', :to => 'question#destroy', as: :delete_answer


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
