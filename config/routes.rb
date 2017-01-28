Rails.application.routes.draw do
  namespace :game do
    resources :rounds do
      resources :kills, only: [:index, :create], shallow: true do
        member do
          put :accept
          put :oppose
        end
      end
      resources :players, only: [:index, :show], shallow: true
    end
  end
  resources :users
  resources :weapons
  resources :places
end
