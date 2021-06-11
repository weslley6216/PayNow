Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :payment_methods
    resources :companies, only: %i[index show edit update]
  end

  namespace :user do
    resources :companies, only: %i[new create show edit]
  end
end
