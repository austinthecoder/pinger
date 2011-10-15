Pinger::Application.routes.draw do

  root :to => "locations#index"

  resources :locations do
    member do
      get :delete
    end
  end

  mount Resque::Server.new => 'resque'

end
