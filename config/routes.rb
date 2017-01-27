Rails.application.routes.draw do
  namespace :game do
    resources :rounds do
      resources :players, only: [:index, :show], shallow: true
    end
  end
  resources :users
  resources :weapons
  resources :places
end
