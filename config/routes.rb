Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :doctors, only: [:index, :show] do
    resources :appointments, only: :create
    resources :reviews, only: :create
  end

  get '/dashboard', to: 'appointments#dashboard'
  get '/meet', to: 'meetings#meet'
end
