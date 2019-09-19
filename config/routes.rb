Rails.application.routes.draw do
  # get 'chart/index'


  namespace :admin do
    resources :employees
    resources :questions
    resources :choices
    resources :materials

    root to: "employees#index"
  end

  devise_for :employees

  scope '(:locale)' do
    resources :homepage

    get 'question/answer/:id' => 'question#new', as: :answer_create
    post 'question/create' => 'question#create', as: :answer_question
    get 'question/edit/:id' => 'question#edit', as: :edit_answer
    patch 'question/:id' => 'question#update', as: :update_answer
    delete 'question/:id/delete', :to => 'question#destroy', as: :delete_answer

    get 'profile/edit/:id' => 'profile#edit', as: :edit_password
    patch 'profile/:id' => 'profile#update', as: :update_password

    get 'material/charts' => 'chart#index', as: :chart_show

    root 'homepage#index'

  end


end
