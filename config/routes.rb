Rails.application.routes.draw do
  get 'pages/index'
  root 'pages#index'
  resources :backlogs
  devise_for :users, controllers:{
   confirmations: 'users/confirmations',
   passwords: 'users/passwords',
   registrations: 'users/registrations',
   sessions: 'users/sessions',
   unlocks: 'users/unlocks',
   invitations: 'users/invitations'
  }
  resources :users, :only => [:index, :show, :update, :edit, :destroy]

  #match '/api/v1/private/backlog/get.json', controller: :"private_api/backlogs", action: :get, format: false, via: [:get]
  #match '/api/v1/private/backlog/upsert.json', controller: :"private_api/backlogs", action: :upsert, format: false, via: [:post]

  match '/api/v1/private/backlog/columns_and_items_get.json', controller: :"private_api/backlogs", action: :get_columns_and_items, format: false, via: [:get]
  match '/api/v1/private/backlog/item_location_update.json',  controller: :"private_api/backlogs", action: :update_item_location,  format: false, via: [:post]
  match '/api/v1/private/backlog/item_info_update.json',      controller: :"private_api/backlogs", action: :update_item_info,      format: false, via: [:post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
