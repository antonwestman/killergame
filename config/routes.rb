Rails.application.routes.draw do
  namespace :game do
    resources :rounds do
      resources :kills, only: [:index], shallow: true
      resources :players, only: [:index, :show], shallow: true do
        member do
          post :kill
          post :accept_kill
          post :oppose_kill
        end
      end
    end
  end
  resources :users
  resources :weapons
  resources :places
end
