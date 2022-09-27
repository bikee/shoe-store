require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  mount Sidekiq::Web => '/sidekiq'
  get 'dashboard', to: 'dashboard#index'
  resources :store_check, path: 'store-check', only: [:index]

  mount ActionCable.server => '/cable'
end
