Rails.application.routes.draw do
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :employees, only: [:index, :show]
    end
  end
  get 'pages/index'
  root 'pages#index'
  devise_for :users, controllers:{
   confirmations: 'users/confirmations',
   passwords: 'users/passwords',
   registrations: 'users/registrations',
   sessions: 'users/sessions',
   unlocks: 'users/unlocks',
   invitations: 'users/invitations'
  }
  resources :users, :only => [:index, :show, :update, :edit, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
