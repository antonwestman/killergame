Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :game do
    resources :rounds do
      member do
        get :me
      end
      resources :kills, only: %i[index create], shallow: true do
        member do
          put :confirm
          put :oppose
        end
      end
      resources :players, only: %i[index show], shallow: true
    end
  end
  resources :users, only: %i[index show update]
  resources :weapons, except: [:show]
  resources :places
end
