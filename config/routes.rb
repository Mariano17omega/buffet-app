Rails.application.routes.draw do
  devise_for :user_owners
  root to: 'home#index'
  get 'login', to:  'home#login'
  resources :buffets, only: [:index, :show, :new, :create, :edit, :update] do
    resources :events, only: [ :show, :new, :create, :edit, :update, :destroy], on: :collection
  end

end
