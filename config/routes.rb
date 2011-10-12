Pinger::Application.routes.draw do

  root :to => "locations#index"

  resources :locations

  mount Resque::Server.new => 'resque'

end
