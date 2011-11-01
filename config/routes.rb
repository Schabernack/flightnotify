Flightnotify::Application.routes.draw do
  root :to => "flights#index"
  
  resources :flights     
  
  
end
