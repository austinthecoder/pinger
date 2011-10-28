Pinger::Application.routes.draw do

  root to: "locations#index"

  resources :locations do
    member do
      get :delete
    end
  end

  resources :email_callbacks do
    member do
      get :delete
    end
  end

  resources :alerts

  mount Resque::Server.new => 'resque'

end