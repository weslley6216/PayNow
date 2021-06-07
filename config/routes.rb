Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :admins

  namespace :admin do
    resources :payment_methods, only: %i[index show new create]
  end
end
