Rails.application.routes.draw do
  root "backlogs#index"
  resources :backlogs
  devise_for :users,
    controllers: {
      confirmations: "users/confirmations",
      passwords: "users/passwords",
      registrations: "users/registrations",
      sessions: "users/sessions",
      unlocks: "users/unlocks",
      invitations: "users/invitations",
    }
  resources :users, :only => [:index, :show, :update, :edit, :destroy]

  #match '/api/v1/private/backlog/get.json', controller: :"private_api/backlogs", action: :get, format: false, via: [:get]
  #match '/api/v1/private/backlog/upsert.json', controller: :"private_api/backlogs", action: :upsert, format: false, via: [:post]

  # backlog
  match "/api/v1/private/backlogs/:id/columns_and_items_get.json", controller: :"private_api/backlogs", action: :get_columns_and_items, format: false, via: [:get]
  match "/api/v1/private/backlogs/:id/item_location_update.json",  controller: :"private_api/backlogs", action: :update_item_location,  format: false, via: [:post]
  # backlog column
  match "/api/v1/private/backlog_columns/create.json",  controller: :"private_api/backlog_columns", action: :create,  format: false, via: [:post]
  match "/api/v1/private/backlog_columns/update.json",  controller: :"private_api/backlog_columns", action: :update,  format: false, via: [:put]
  match "/api/v1/private/backlog_columns/destroy.json", controller: :"private_api/backlog_columns", action: :destroy, format: false, via: [:delete]
  # backlog item
  match "/api/v1/private/backlog_items/create.json",  controller: :"private_api/backlog_items", action: :create,  format: false, via: [:post]
  match "/api/v1/private/backlog_items/update.json",  controller: :"private_api/backlog_items", action: :update,  format: false, via: [:put]
  match "/api/v1/private/backlog_items/destroy.json", controller: :"private_api/backlog_items", action: :destroy, format: false, via: [:delete]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
