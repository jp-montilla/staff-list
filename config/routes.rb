Rails.application.routes.draw do
  get 'chart/index'

  root 'homepage#index'

  namespace :admin do
    resources :employees
    resources :questions
    resources :choices
    resources :materials

    root to: "employees#index"
  end

  devise_for :employees

  resources :homepage

  get 'question/answer/:id' => 'question#new', as: :answer_create
  post 'question/create' => 'question#create', as: :answer_question
  get 'question/edit/:id' => 'question#edit', as: :edit_answer
  patch 'question/:id' => 'question#update', as: :update_answer
  delete 'question/:id/delete', :to => 'question#destroy', as: :delete_answer

  get 'profile/edit/:id' => 'profile#edit', as: :edit_password
  patch 'profile/:id' => 'profile#update', as: :update_password

  get 'material/charts' => 'chart#index', as: :chart_show



end
