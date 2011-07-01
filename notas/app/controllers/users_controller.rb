class UsersController < ApplicationController
  skip_before_filter :require_logged, :if=>:no_users
  before_filter :require_no_users
  

  # render new.rhtml
  def new
    @user = Administrator.new
  end
 
  def create
    logout_keeping_session!
    @user = Administrator.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in (como Administrador)
      redirect_back_or_default('/')
      flash[:notice] = "Administrador creado con éxito."
    else
      flash[:error]  = "No se ha podido crear el usuario."
      render :action => 'new'
    end
  end

protected

  def no_users
    Administrator.count==0
  end

  def require_no_users
    unless no_users
      flash[:error] = 'Solo se permite crear un usuario Administrador.'
      redirect_to '/'
    end
  end
end
