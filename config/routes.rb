Rails.application.routes.draw do
  devise_for :user_clients
  devise_for :user_owners
  root to: 'home#index'
  get 'login', to:  'home#login'
  get 'sign_up', to:  'home#sign_up'

  resources :buffets, only: [:index, :show, :new, :create, :edit, :update] do
    resources :events, only: [:show, :new, :create, :edit, :update, :destroy], on: :collection do
      resources :orders, only: [:show, :new, :create, :edit, :update], shallow: true do
        member do
          put :canceled_status
        end
      end
    end
    get 'search', on: :collection
  end
  get 'my_orders', to: 'orders#my_orders'
  get 'orders_buffet', to: 'orders#orders_buffet'

  resources :profiles, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      get '/buffets/search', to: 'buffets#search'
      resources :buffets, only: [:show, :index] do
        resources :events, only:  [ :index]
      end
      post '/events/availability', to: 'events#availability'
    end
  end

end
