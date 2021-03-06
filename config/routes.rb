Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'application#index'
  resources :events
  resources :strava, only: [] do
    post 'token', on: :collection
  end
end
