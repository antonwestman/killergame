Rails.application.routes.draw do
  namespace :game do
    resources :players
  end
  resources :users
end
