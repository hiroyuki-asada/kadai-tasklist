Rails.application.routes.draw do
  

  
get '/', to: 'toppages#index'
  
get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'

  #get 'tasks/:user_id', to: 'tasks#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

get 'signup', to: 'users#new'

resources :tasks

resources :users, only: [:show, :new, :create, :index]

end

