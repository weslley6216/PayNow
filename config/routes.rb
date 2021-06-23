Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :payment_methods
    resources :companies, except: %i[new create], param: :token do
      resources :charges, only: %i[index show update]
      put 'regenerate_token', on: :member
    end
  end

  namespace :user do
    resources :payment_methods, only: %i[index show] do
      resources :bank_slips, only: %i[new create show]
      resources :credit_cards, only: %i[new create show]
      resources :pixes, only: %i[new create show]
    end
    resources :companies, only: %i[new create show edit], param: :token do
      put 'regenerate_token', on: :member
      resources :products
    end
  end

  namespace :api do
    namespace :v1 do
      resources :final_clients, only: %i[create]
      resources :charges, only: %i[create index]
    end
  end
end
