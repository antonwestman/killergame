Rails.application.routes.draw do
  namespace :game do
    resources :players
    resources :rounds
  end
  resources :users
  resources :weapons
  resources :places
end
