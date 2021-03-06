require 'sidekiq/web'

Rails.application.routes.draw do
  mount API::Root => '/'
  mount Sidekiq::Web => '/sidekiq'

  get 'visualize', to: 'visualizers#index'
end
