Rails.application.routes.draw do

  namespace :admin do
    resources :employees
    resources :questions
    resources :choices
    resources :materials

    root to: "employees#index"
  end

  resources :choices, :except => [:new, :create,:destroy]
  get '/choice/new/:id', to: 'choices#new', as: :new_choice
  post '/choice/create', to: 'choices#create', as: :create_choice
  patch '/choice/:id', to: 'choices#update', as: :update_choice
  delete '/choice/:id/delete', to: 'choices#destroy', as: :delete_choice


  resources :assigns, :except => [:new, :create,:destroy, :show]
  get '/assign/new/:id', to: 'assigns#new', as: :new_assign
  get '/assign/show', to: 'assigns#show', as: :assign_close
  patch '/assign/create/:id', to: 'assigns#create', as: :create_assign
  patch '/assign/destroy/:id', to: 'assigns#destroy', as: :destroy_assign

  resources :views, :except => [:create,:destroy]
  patch '/view/create/:id', to: 'views#create', as: :create_view
  patch '/view/destroy/:id', to: 'views#destroy', as: :destroy_view

  

  devise_for :employees
  # devise_for :employees, controllers: {
  #       sessions: 'employees/sessions'
  #     }

  scope '(:locale)' do
    resources :homepages, :except => [:new, :create,:destroy]
    get 'homepage/new/:id', to: 'homepages#new', as: :answer_new
    post '/homepage/create', to: 'homepages#create', as: :answer_create
    patch '/homepage/:id', to: 'homepages#update', as: :answer_update
    delete 'homepage/:id/delete', to: 'homepages#destroy', as: :answer_delete

    get 'material/charts' => 'charts#index', as: :chart_show

    root 'homepages#index'

  end


end
