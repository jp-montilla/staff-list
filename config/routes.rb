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
    resources :homepage, :except => [:new, :create,:destroy]
    get 'homepage/new/:id', to: 'homepage#new', as: :answer_new
    post '/homepage/create', to: 'homepage#create', as: :answer_create
    patch '/homepage/:id', to: 'homepage#update', as: :answer_update
    delete 'homepage/:id/delete', to: 'homepage#destroy', as: :answer_delete

    #get 'question/answer/:id' => 'question#new', as: :answer_create
    #post 'question/create' => 'question#create', as: :answer_question
    #get 'question/edit/:id' => 'question#edit', as: :edit_answer
    #patch 'question/:id' => 'question#update', as: :update_answer
    #delete 'question/:id/delete', :to => 'question#destroy', as: :delete_answer

    get 'profile/edit/:id' => 'profile#edit', as: :edit_password
    patch 'profile/:id' => 'profile#update', as: :update_password

    get 'material/charts' => 'chart#index', as: :chart_show

    root 'homepage#index'

  end


end
