Pinger::Application.routes.draw do

  root :to => "locations#index"

  resources :locations do
    collection do
      post :schedule_pings
    end
  end

  mount Resque::Server.new => 'resque'

end
