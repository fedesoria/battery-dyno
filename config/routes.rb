
Dynobattery::Application.routes.draw do |map|
  
  match '/documentation' => 'pages#documentation'
  match '/index' => 'pages#index'
  match '/about' => 'pages#about'
  match '/contact' => 'pages#contact'
  
  resources :users
  # , :except => :index
  
  post    '/heroku/resources' => 'heroku#create'
  get     '/heroku/resources/:id' => 'heroku#login'
  delete  '/heroku/resources/:id' => 'heroku#destroy'
  
  
  match '/users/:id/email_change' => 'users#save_email'
  
  match '/heroku', :to => RequestsCall
  
  match '/heroku_time', :to => TimeRequest
  
  match '/heroku/dashboard' => 'heroku#dashboard'
  

  root :to => "pages#index"


end
