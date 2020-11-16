Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :doctors, only: [:index, :show] do
    resources :appointments, only: :create
    resources :reviews, only: :create
  end

  get '/my_appointments', to: 'appointments#my_appointments'
end
