Rails.application.routes.draw do
  devise_for :user_owners
  root to: 'home#index'
  resources :buffets, only: [:index, :show, :new, :create, :edit, :update]
end
