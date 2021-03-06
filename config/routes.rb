Flightnotify::Application.routes.draw do

  get "/subscriptions/:id/destroy" => "subscriptions#destroy", :as => "unsubscribe"
  
  root :to => "flights#index"
  
  resources :flights do 
    collection do 
      post 'preview'
      post 'subscribe'
      post 'remove_from_db'
    end
  end
           
  
  
end
