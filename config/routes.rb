Pinger::Application.routes.draw do

  root :to => 'resources#index'

  resources :resources, :only => %w[new] do
  #   member do
  #     get :delete
  #   end

  #   resources :alerts
  end

  resources :email_callbacks do
    member do
      get :delete
    end
  end

  resources :alerts

  mount Resque::Server.new => 'resque'

end