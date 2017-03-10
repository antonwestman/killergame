Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :game do
    resources :rounds do
      member do
        get :me
      end
      resources :kills, only: [:index, :create], shallow: true do
        member do
          put :confirm
          put :oppose
        end
      end
      resources :players, only: [:index, :show], shallow: true
    end
  end
  resources :users, only: [:index, :show, :update]
  resources :weapons, except: [:show]
  resources :places
end
