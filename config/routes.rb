Rails.application.routes.draw do
  root to: 'pages#home'

  resouces :doctors, only: [:index, :show] do
    resouces :appointments, only: :create
    resouces :reviews, only: :create
  end

  get '/my_appointments', to: 'appointments#my_appointments'
end

