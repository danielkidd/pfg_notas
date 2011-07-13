ActionController::Routing::Routes.draw do |map|
  map.resources :years

  map.resources :signatures, :member => {
      :create_student => :post,
      :destroy_student => :delete,
      :create_teacher => :post,
      :destroy_teacher => :delete
    }

  map.resources :teachers

  map.resources :students

  map.resources :users, :only => [:new, :create] # para crear el administrador

  map.home '', :controller => 'home', :action => 'index'
  map.change_year '/change_year', :controller => 'home', :action => 'change_year'
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.login '/new_admin', :controller => 'users', :action => 'new'

  map.resource :session

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
