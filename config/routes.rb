Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :payment_methods
    resources :companies
  end

  namespace :user do
    resources :payment_methods, only: %i[index show] do
      resources :bank_slips, only: %i[new create show]
      resources :credit_cards, only: %i[new create show]
      resources :pixes, only: %i[new create show]
    end
    resources :companies, only: %i[new create show edit] do
      get 'my_company', on: :member
    end
  end
end
