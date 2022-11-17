Rails.application.routes.draw do
  root 'site/welcome#index'

  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject/:id/:description', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end
  
  namespace :users_backoffice do
    get   'welcome/index'
    get   'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  
  namespace :admins_backoffice do
    get 'dashboard', to: 'welcome#index' # Dashboard
    resources :admins, except: [:show]
    resources :subjects, except: [:show]
    resources :questions
  end
  
  devise_for :users
  devise_for :admins, skip: [:registrations]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
