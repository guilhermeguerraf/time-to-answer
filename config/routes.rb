Rails.application.routes.draw do
  root 'site/welcome#index'

  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
  end
  
  namespace :users_backoffice do
    get 'welcome/index'
  end
  
  namespace :admins_backoffice do
    get 'dashboard', to: 'welcome#index' # Dashboard
    resources :admins, except: [:show]
    resources :subjects, except: [:show]
    resources :questions
  end
  
  devise_for :users
  devise_for :admins
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
