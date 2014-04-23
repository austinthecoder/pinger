Pinger::Application.routes.draw do
  root to: "locations#index"

  resources :locations do
    member do
      get :delete
    end

    resources :alerts
  end

  resources :email_callbacks do
    member do
      get :delete
    end
  end

  resources :alerts

  namespace 'admin' do
    mount Sidekiq::Web => '/sidekiq'
  end
end