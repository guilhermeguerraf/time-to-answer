Rails.application.routes.draw do
  root 'site/welcome#index'
  get  'backoffice', to: 'admins_backoffice/welcome#index' # Dashboard

  namespace :site do
    root 'welcome#index'
    get  'search',                   to: 'search#questions'
    get  'subject/:id/:description', to: 'search#subject',  as: 'search_subject'
    get  'subjects',                 to: 'subjects#index'
    get  'subjects/:id',             to: 'subjects#show',   as: 'subject'
    get  'questions',                to: 'questions#index'
    post 'answer',                   to: 'answer#question'
  end
  
  namespace :users_backoffice do
    root  'welcome#index'
    get   'welcome/index'
    get   'profile',  to: 'profile#edit'
    patch 'profile',  to: 'profile#update'
    get   'zip_code', to: 'zip_code#show'
    get   'favorites', to: 'favorite_questions#index'
    delete   'favorite_questions/:id', to: 'favorite_questions#destroy',  as: 'favorite_question'
    post  'favorite',        to: 'favorite_questions#favorite'
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
