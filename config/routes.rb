Rails.application.routes.draw do
  root 'site/welcome#index'
  get  'backoffice', to: 'admins_backoffice/welcome#index' # Dashboard

  namespace :site do
    root 'welcome#index'
    get  'search',                   to: 'search#questions'
    get  'subject/:id/:description', to: 'search#subject',   as: 'search_subject'
    post 'answer',                   to: 'answer#question'
    resources :subjects, only: [:index, :show]
    resources :questions, only: [:index]
  end
  
  namespace :users_backoffice do
    root  'welcome#index'
    get   'welcome/index'
    get   'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  
  namespace :admins_backoffice do
    root 'welcome#index'
    get  'dashboard', to: 'welcome#index' # Dashboard

    resources :admins,   except: [:show]
    resources :subjects, except: [:show]
    resources :questions
  end
  
  devise_for :users
  devise_for :admins, skip: [:registrations]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
