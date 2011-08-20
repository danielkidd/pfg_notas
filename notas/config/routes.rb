ActionController::Routing::Routes.draw do |map|
  map.resources :degrees

  map.resources :years

  map.resources :signatures, :member => {
      :create_student => :post,
      :destroy_student => :delete,
      :create_teacher => :post,
      :destroy_teacher => :delete,
      :calcular_medias => :get
    } do |signature|
      signature.resources :parts do |part|
        part.resources :exams do |exam|
          exam.resources :evaluations, :only => [:create, :update, :destroy]
        end
      end
    end

  map.resources :teachers

  map.resources :students

  map.resources :users, :only => [:new, :create] # para crear el administrador

  map.home '', :controller => 'home', :action => 'index'
  map.change_year '/change_year', :controller => 'home', :action => 'change_year'
  map.change_degree '/change_degree', :controller => 'home', :action => 'change_degree'
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.login '/new_admin', :controller => 'users', :action => 'new'

  map.resource :session

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
