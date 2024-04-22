Rails.application.routes.draw do
  devise_for :user_owners
  root to: 'home#index'
end
