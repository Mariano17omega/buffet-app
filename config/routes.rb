Rails.application.routes.draw do
  devise_for :user_clients
  devise_for :user_owners
  root to: 'home#index'
  get 'login', to:  'home#login'
  get 'sign_up', to:  'home#sign_up'
  resources :buffets, only: [:index, :show, :new, :create, :edit, :update] do
    resources :events, only: [ :show, :new, :create, :edit, :update, :destroy], on: :collection
  end

end
