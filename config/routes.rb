Flightnotify::Application.routes.draw do
  root :to => "flights#index"
  
  resources :flights do 
    collection do 
      post 'preview'
      post 'subscribe'
    end
  end
           
  
  
end
